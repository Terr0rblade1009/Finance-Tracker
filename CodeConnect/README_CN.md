# Figma Code Connect — 自定义解析器与模板文件

本文档介绍了使用 [Figma Code Connect](https://github.com/figma/code-connect) 将代码库连接到 Figma 组件的两种主要方式：**模板文件（Template Files）** 和 **自定义解析器（Custom Parsers）**。

---

## 目录

- [概述](#概述)
- [模板文件](#模板文件)
  - [配置](#模板配置)
  - [文件格式](#模板文件格式)
  - [元数据注释](#元数据注释)
  - [构建代码片段](#构建代码片段)
  - [嵌套实例处理](#嵌套实例处理)
  - [导出格式](#导出格式)
  - [迁移脚本](#迁移脚本beta)
  - [在 Figma 中测试](#在-figma-中测试)
- [自定义解析器](#自定义解析器)
  - [配置](#自定义解析器配置)
  - [命令](#命令)
  - [模式：PARSE](#模式parse)
  - [模式：CREATE](#模式create)
  - [输入类型](#输入类型)
  - [输出类型](#输出类型)
  - [模板实现示例](#模板实现示例)
- [模板文件 vs 自定义解析器](#模板文件-vs-自定义解析器)
  - [核心区别](#核心区别)
  - [如何选择](#如何选择)
  - [两者的关系](#两者的关系)

---

## 概述

Code Connect 允许你将源代码链接到 Figma 组件，使设计师在 Figma 检查面板中能够看到真实的代码片段。有两种方式来定义这些连接：

| 方式 | 简介 |
|---|---|
| **模板文件** | 编写 `.figma.ts` / `.figma.js` 文件，直接使用 Template API。CLI 原生读取，无需额外解析器。 |
| **自定义解析器** | 以任意格式编写 Code Connect 文件，然后构建解析器通过 stdin/stdout JSON 将其转换为 Template API 输出。 |

---

## 模板文件

模板文件提供了一种与框架无关的方式来连接代码和 Figma 组件。无需依赖特定框架的解析器，你只需编写 TypeScript 文件来明确定义组件的显示方式。这种方式更易维护、更灵活、也比框架特定的 API 更强大。

模板文件让你完全控制代码生成，适用于以下场景：

- **框架无关的连接** — 无论使用什么框架或语言，都能连接你的代码库
- **精确的代码控制** — 生成你想要的精确代码，无需依赖解析器 API

> Figma 正在积极将模板文件作为 Code Connect 的主要格式进行投入。

### 模板配置

1. 确保 `figma.config.json` 包含 `.figma.ts`（或 `.figma.js`）文件，并设置 `label` 和 `language`：

```json
{
  "codeConnect": {
    "include": ["**/*.figma.ts"],
    "label": "React",
    "language": "jsx"
  }
}
```

2. 如果使用 TypeScript，将模板类型定义添加到 `tsconfig.json` 以获得自动补全和类型检查：

```json
{
  "compilerOptions": {
    "types": ["@figma/code-connect/figma-types"]
  }
}
```

3. 编写你的 `.figma.ts` 文件（见下文）。

4. 将模板文件发布到 Figma：

```bash
npx figma connect publish
```

### 模板文件格式

模板文件将你的代码连接到 Figma 中的组件，并指定该组件实例在代码片段中的显示方式。

```ts
// MyComponent.figma.ts

// url=https://www.figma.com/file/your-file-id/Component?node-id=123
import figma from 'figma'

const instance = figma.selectedInstance

const labelText = instance.getString('Label')
const iconInstance = instance.findInstance('Icon')

export default {
  example: figma.code`
    <MyComponent
      label={${labelText}}
      icon={${iconInstance.executeTemplate().example}}
    />
  `,
  imports: ['import MyComponent from "components/MyComponent"'],
  id: 'my-component',
  metadata: {
    nestable: true,
  },
}
```

### 元数据注释

每个模板文件必须以如下格式的特殊注释开头：

| 注释 | 必填 | 说明 |
|---|---|---|
| `url` | 是 | Figma 组件的 URL。在 Figma 中右键点击组件，选择"复制所选内容的链接"。 |
| `source` | 否 | 代码组件的文件路径（或 URL）。在 Figma 中显示。 |
| `component` | 否 | 代码组件的名称。在 Figma 中显示。 |

```ts
// url=https://www.figma.com/file/your-file-id/Component?node-id=123
// source=src/components/MyButton.tsx
// component=MyButton
```

### 构建代码片段

#### 访问实例属性

使用 `figma.selectedInstance` 上的方法读取 Figma 组件的属性：

```ts
import figma from 'figma'

const instance = figma.selectedInstance

// 字符串属性
const label = instance.getString('Label')

// 布尔属性
const disabled = instance.getBoolean('Disabled')

// 枚举属性 — 将 Figma 值映射为代码值
const size = instance.getEnum('Size', {
  Small: 'sm',
  Medium: 'md',
  Large: 'lg',
})
```

### 嵌套实例处理

要包含嵌套的组件实例（如按钮内的图标），使用 `findInstance()` 或 `getInstanceSwap()` 定位子组件，然后调用 `executeTemplate()` 渲染它：

```ts
import figma from 'figma'

const instance = figma.selectedInstance

// 通过图层名查找嵌套实例
const iconInstance = instance.findInstance('Icon')

// 获取嵌套实例的代码片段
const iconSnippet = iconInstance.executeTemplate().example
```

> **重要提示：** 代码片段底层使用数组结构。不要对其执行字符串操作（如拼接）。请使用 `figma.code` 包裹：

```ts
figma.code`<MyExample/>${showIcon ? iconSnippet : null}`
```

#### 渲染你的代码片段

将代码包裹在 `figma.code` 中来构建示例：

```ts
import figma from 'figma'

const instance = figma.selectedInstance

const example = figma.code`Button(
  variant = ButtonVariant.Primary
)`
```

### 导出格式

模板文件应包含如下格式的默认导出：

```ts
export default {
  // 你构建的代码片段，使用 figma.code`...` 包裹
  example: ResultSection[],

  // 渲染在代码片段顶部的导入语句数组。
  // 嵌套片段会自动提升并去重导入。
  imports: string[],

  // 标识此模板，允许其他模板引用它
  id: string,

  metadata?: {
    // 嵌套在父组件中时是否内联显示（默认：false）
    nestable?: boolean,
    // 通过 executeTemplate().metadata.props 提供给父模板的数据
    props?: Record<string, any>,
  }
}
```

### 迁移脚本（Beta）

> 迁移脚本正在积极开发中。

将现有的基于解析器的 Code Connect 文件转换为模板文件：

```bash
npx figma connect migrate [options]
```

| 选项 | 说明 |
|---|---|
| `--outDir <dir>` | 将模板文件写入指定目录，而非源文件旁 |
| `--javascript` | 输出 `.figma.js` 文件而非默认的 `.figma.ts` |
| `--include-props` | 在迁移输出中保留 `__props` 元数据块 |

迁移后的文件使用 `figma.helpers` 确保正确渲染。当你清楚确切的输出时，可以简化生成的代码。例如：

```ts
// 生成的（冗长）
figma.code`<Counter${figma.helpers.react.renderProp('count', count)} />`

// 简化的（手动）
figma.code`<Counter count={${count}} />`
```

### 在 Figma 中测试

设置临时配置以在不影响现有 Code Connect 的情况下进行测试：

```json
{
  "include": ["**/*.figma.ts"],
  "label": "TEST",
  "language": "jsx"
}
```

```bash
# 在临时标签下发布
npx figma connect publish --config <你的 figma.config.json 路径>

# 完成后移除
npx figma connect unpublish --config <你的 figma.config.json 路径>
```

---

## 自定义解析器

> **注意：** 自定义解析器支持目前处于预览阶段，API 可能会发生变化。请通过 [创建 GitHub Issue](https://github.com/figma/code-connect/issues) 分享反馈。

自定义解析器允许你为原生不支持的语言添加 Code Connect 支持。你可以用**任意自定义格式**编写 Code Connect 文件，然后构建一个解析器可执行文件将其转换为 Template API 输出。

### 自定义解析器配置

自定义解析器必须在 `figma.config.json` 中配置：

```json
{
  "codeConnect": {
    "parser": "custom",
    "parserCommand": "node ../parserDirectory/parser.js",
    "include": [
      "**/*.figma.test"
    ],
    "exclude": []
  }
}
```

| 字段 | 必填 | 说明 |
|---|---|---|
| `parser` | 是 | 必须设置为 `"custom"` |
| `parserCommand` | 是 | 调用解析器的完整路径或命令（如 `./tools/parser` 或 `node parser.js`） |
| `include` | 是 | 在 `parse` 或 `publish` 时传递给解析器的文件 glob 模式 |
| `exclude` | 否 | 要排除的文件 glob 模式 |

### 命令

#### 发布和解析（Publish / Parse）

CLI 收集所有匹配 `include`/`exclude` 的文件，然后通过 **stdin** 将 `ParseRequestPayload` 传递给 `parserCommand`。解析器通过 **stdout** 输出 `ParseResponsePayload`。如果是发布操作，CLI 会将文档发送到 Figma。

```bash
npx figma connect publish --config figma.config.json --token <auth token>
```

#### 创建（Create）

CLI 从 Figma 获取组件定义，然后通过 **stdin** 将 `CreateRequestPayload` 传递给 `parserCommand`。解析器创建 Code Connect 文件并通过 **stdout** 返回 `CreateResponsePayload`。

```bash
npx figma connect create "<url_to_node>" --config figma.config.json --token <auth token>
```

### 工作流程详解

#### 模式：PARSE

```
CLI                              你的解析器
 |                                    |
 |-- 1. 通过 include/exclude ------> |
 |      匹配文件                       |
 |                                    |
 |-- 2. 发送 ParseRequestPayload --> |  （通过 stdin）
 |      { mode: "PARSE",             |
 |        paths: [...],              |
 |        config: { ... } }          |
 |                                    |
 |  <-- 3. 接收 ParseResponsePayload    （通过 stdout）
 |      { docs: [...],               |
 |        messages: [...] }           |
 |                                    |
 |-- 4. 如果是发布：上传文档 -------> Figma API
```

你的解析器在第 3 步需要完成：
1. 读取 `paths` 中的每个文件
2. 以适合你语言的方式解析它们
3. 为每个找到的 Code Connect 定义，生成包含模板、属性映射和元数据的文档对象
4. 将完整的响应以 JSON 格式输出到 stdout

#### 模式：CREATE

```
CLI                              你的解析器
 |                                    |
 |-- 1. 获取组件信息 ---------------> Figma API
 |      （属性、名称、类型）            |
 |                                    |
 |-- 2. 发送 CreateRequestPayload -> |  （通过 stdin）
 |      { mode: "CREATE",            |
 |        destinationDir: "...",      |
 |        component: { ... } }        |
 |                                    |
 |  <-- 3. 接收 CreateResponsePayload    （通过 stdout）
 |      { createdFiles: [...],        |
 |        messages: [...] }           |
```

你的解析器在第 3 步需要完成：
1. 为组件生成样板 Code Connect 文件
2. 将文件写入 `destinationDir`
3. 返回已创建文件的路径列表

### 输入类型

#### ParseRequestPayload

```ts
type ParseRequestPayload = {
  mode: 'PARSE'
  // 由 include/exclude glob 匹配的所有文件的绝对路径
  paths: string[]
  // 来自 figma.config.json 中此解析器的配置选项
  config: Record<string, any>
}
```

#### CreateRequestPayload

```ts
type CreateRequestPayload = {
  mode: 'CREATE'
  // 创建文件的绝对目标目录
  destinationDir: string
  // 可选的目标文件名
  destinationFile?: string
  // 要连接的代码文件路径
  sourceFilepath?: string
  // 从 sourceFilepath 使用的导出（仅 TypeScript）
  sourceExport?: string
  // Figma 属性到代码属性的映射
  propMapping?: PropMapping
  // Figma 组件的信息
  component: {
    figmaNodeUrl: string
    id: string
    name: string
    normalizedName: string
    type: 'COMPONENT' | 'COMPONENT_SET'
    componentPropertyDefinitions: Record<string, ComponentPropertyDefinition>
  }
  config: Record<string, any>
}

type ComponentPropertyDefinition = {
  type: 'BOOLEAN' | 'INSTANCE_SWAP' | 'TEXT' | 'VARIANT'
  defaultValue: boolean | string
  // 仅存在于 VARIANT 类型的属性
  variantOptions?: string[]
}
```

### 输出类型

#### ParseResponsePayload

```ts
const ParseResponsePayload = {
  docs: {
    // Figma 节点 URL（如 https://www.figma.com/design/123/MyFile?node-id=1-1）
    figmaNode: string,
    // 可选的组件名称（仅用于显示）
    component?: string,
    // 按 Figma 属性名称键入的变体限制
    variant?: Record<string, string>,
    // 组件源文件的相对路径
    source: string,
    // 可选的行号（用于链接）
    sourceLocation?: { line: number },
    // 使用 Template API 的 JavaScript 模板函数
    template: string,
    templateData: {
      props: PropMapping,
      imports?: string[],
      nestable?: boolean,
    },
    // 语法高亮语言
    language: SyntaxHighlightLanguage,
    // UI 中示例的标签
    label: string,
  }[],
  messages: ParserMessage[],
}
```

#### CreateResponsePayload

```ts
const CreateResponsePayload = {
  createdFiles: {
    filePath: string, // 创建文件的绝对路径
  }[],
  messages: ParserMessage[],
}
```

#### ParserMessage

```ts
type ParserMessage = {
  level: 'DEBUG' | 'INFO' | 'WARN' | 'ERROR',
  type?: string,
  message: string,
  sourceLocation?: {
    file: string,
    line?: number,
  },
}
```

#### 支持的语法高亮语言

`typescript` | `cpp` | `ruby` | `css` | `javascript` | `html` | `json` | `graphql` | `python` | `go` | `sql` | `swift` | `kotlin` | `rust` | `bash` | `xml` | `plaintext` | `jsx` | `tsx` | `dart`

### 模板实现示例

以下是一个完整示例，展示解析器如何使用 Template API 生成模板：

```js
const figma = require('figma')
const instance = figma.selectedInstance

// 获取属性值
const stringProp = instance.getString('String Prop')
const booleanProp = instance.getBoolean('Boolean Prop')
const enumProp = instance.getEnum('Enum Prop', {
  'Option1': 'value1',
  'Option2': 'value2'
})

// 查找图层
const textLayer = instance.findText('Label')
const childInstance = instance.findInstance('Icon')
const connectedInstance = instance.findConnectedInstance('button-123')

// 使用选择器选项
const nestedText = instance.findText('Description', {
  path: ['Container', 'Content'],
  traverseInstances: true
})

// 使用选择器函数
const allButtons = instance.findConnectedInstances(
  node => node.properties['type'] === 'button'
)

export default {
  example: figma.code`<Component
    label={${stringProp}}
    enabled={${booleanProp}}
    variant={${enumProp}}
    icon={${childInstance?.executeTemplate().example}}
  />`,
  id: 'example-id'
}
```

---

## 模板文件 vs 自定义解析器

### 核心区别

| | 模板文件 | 自定义解析器 |
|---|---|---|
| **文件格式** | 始终为 `.figma.ts` / `.figma.js` | 任意自定义格式（`.figma.dart`、`.figma.swift` 等） |
| **编写语言** | TypeScript / JavaScript | 你自己的 DSL 或语言 |
| **是否需要解析器？** | 否 — CLI 原生支持 | 是 — 需要你自行构建和维护 |
| **Template API** | 由你直接编写 | 由你的解析器作为输出生成 |
| **配置中的 `parser`** | 省略（默认） | `"custom"` |
| **通信方式** | CLI 直接读取文件 | CLI 通过 stdin/stdout JSON 调用解析器 |
| **复杂度** | 较低 — 只需编写模板 | 较高 — 需要构建翻译层 |
| **Figma 推荐** | 是 — 作为主要格式积极投入 | 适用于模板文件不太实用的语言 |

### 如何选择

**使用模板文件的场景：**
- 团队能够编写 TypeScript（即使组件使用其他语言）
- 需要最简单的配置，无需额外基础设施
- 希望使用 Figma 推荐的、积极支持的方式

**使用自定义解析器的场景：**
- 希望 Code Connect 文件与组件使用相同语言编写（如 `.figma.swift` 与 `.swift` 并存）
- 需要 DSL 或基于注解的方式，使其与技术栈融为一体
- 愿意构建和维护解析器基础设施

### 两者的关系

自定义解析器最终产出与模板文件**完全相同**的输出。`ParseResponsePayload` 中的 `template` 字段就是你在 `.figma.ts` 文件中手写的同一段 Template API JavaScript。区别只在于**谁来编写这段 JavaScript**：

```
模板文件：      你  -->  Template API JS  -->  Figma
自定义解析器：  你  -->  你的格式  -->  你的解析器  -->  Template API JS  -->  Figma
```

两种方式最终发布到 Figma 的内容完全一致 — 自定义解析器只是增加了一个由你拥有和维护的翻译层。

> **本项目**使用 `"parser": "swift"`（由 Figma 维护的内置解析器），这是一种折中方案 — 你编写 `.figma.swift` 文件，无需自己构建解析器。
