# Figma Code Connect — Custom Parsers & Template Files

This document explains the two main approaches for connecting your codebase to Figma components using [Figma Code Connect](https://github.com/figma/code-connect): **Template Files** and **Custom Parsers**.

---

## Table of Contents

- [Overview](#overview)
- [Template Files](#template-files)
  - [Setup](#template-setup)
  - [File Format](#template-file-format)
  - [Metadata Comments](#metadata-comments)
  - [Building the Snippet](#building-the-snippet)
  - [Working with Nested Instances](#working-with-nested-instances)
  - [Export Format](#export-format)
  - [Migration from Parser-based Files](#migration-script-beta)
  - [Testing in Figma](#testing-in-figma)
- [Custom Parsers](#custom-parsers)
  - [Config](#custom-parser-config)
  - [Commands](#commands)
  - [Mode: PARSE](#mode-parse)
  - [Mode: CREATE](#mode-create)
  - [Input Types](#input-types)
  - [Output Types](#output-types)
  - [Example Template Implementation](#example-template-implementation)
- [Template Files vs Custom Parsers](#template-files-vs-custom-parsers)
  - [Key Differences](#key-differences)
  - [When to Use Which](#when-to-use-which)
  - [How They Relate](#how-they-relate)

---

## Overview

Code Connect lets you link your source code to Figma components so that designers see real code snippets in the Figma inspector panel. There are two ways to define these connections:

| Approach | Summary |
|---|---|
| **Template Files** | Write `.figma.ts` / `.figma.js` files using the Template API directly. The CLI reads them natively — no parser needed. |
| **Custom Parsers** | Write Code Connect files in any format, then build a parser that translates them into the Template API output via stdin/stdout JSON. |

---

## Template Files

Template files provide a framework-agnostic way to connect your code to Figma components. Instead of relying on framework-specific parsers, you write TypeScript files that explicitly define how your components should be displayed. This approach is simpler to maintain, more flexible, and more powerful than framework-specific APIs.

Template files give you full control over code generation, making them ideal when you need:

- **Framework-agnostic connections** — connect any codebase, regardless of framework or language
- **Precise code control** — generate exactly the code you want, without relying on parser APIs

> Figma is actively investing in template files as the primary Code Connect format.

### Template Setup

1. Make sure your `figma.config.json` includes `.figma.ts` (or `.figma.js`) files, and set `label` and `language`:

```json
{
  "codeConnect": {
    "include": ["**/*.figma.ts"],
    "label": "React",
    "language": "jsx"
  }
}
```

2. If using TypeScript, add the template type definitions to your `tsconfig.json` for autocomplete and type checking:

```json
{
  "compilerOptions": {
    "types": ["@figma/code-connect/figma-types"]
  }
}
```

3. Write your `.figma.ts` files (see below).

4. Publish your template files to Figma:

```bash
npx figma connect publish
```

### Template File Format

Template files connect your code to a component in Figma and specify how instances of that component should appear in the code snippet.

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

### Metadata Comments

Each template file must start with a block of special comments:

| Comment | Required | Description |
|---|---|---|
| `url` | Yes | The Figma component URL. Right-click on a component in Figma and select "Copy link to selection". |
| `source` | No | The filepath (or URL) of your code component. Displayed in Figma. |
| `component` | No | The name of your code component. Displayed in Figma. |

```ts
// url=https://www.figma.com/file/your-file-id/Component?node-id=123
// source=src/components/MyButton.tsx
// component=MyButton
```

### Building the Snippet

#### Accessing Instance Properties

Use the methods on `figma.selectedInstance` to read properties from your Figma component:

```ts
import figma from 'figma'

const instance = figma.selectedInstance

// String property
const label = instance.getString('Label')

// Boolean property
const disabled = instance.getBoolean('Disabled')

// Enum property — map Figma values to code values
const size = instance.getEnum('Size', {
  Small: 'sm',
  Medium: 'md',
  Large: 'lg',
})
```

### Working with Nested Instances

To include nested component instances (like an icon inside a button), use `findInstance()` or `getInstanceSwap()` to locate the child, then call `executeTemplate()` to render it:

```ts
import figma from 'figma'

const instance = figma.selectedInstance

// Find a nested instance by layer name
const iconInstance = instance.findInstance('Icon')

// Get the snippet from the nested instance
const iconSnippet = iconInstance.executeTemplate().example
```

> **Important:** Snippets use an array structure under the hood. Do not perform string operations (like concatenation) on them. Instead, wrap them in `figma.code`:

```ts
figma.code`<MyExample/>${showIcon ? iconSnippet : null}`
```

#### Rendering Your Snippet

Build your example by writing your code wrapped in `figma.code`:

```ts
import figma from 'figma'

const instance = figma.selectedInstance

const example = figma.code`Button(
  variant = ButtonVariant.Primary
)`
```

### Export Format

Your template file should contain a default export in this format:

```ts
export default {
  // Your constructed snippet, wrapped in figma.code`...`
  example: ResultSection[],

  // Array of import strings rendered at the top of the snippet.
  // Nested snippets hoist and deduplicate imports automatically.
  imports: string[],

  // Identifies this template, allowing other templates to reference it
  id: string,

  metadata?: {
    // Whether the snippet displays inline when nested in a parent (default: false)
    nestable?: boolean,
    // Data available to parent templates through executeTemplate().metadata.props
    props?: Record<string, any>,
  }
}
```

### Migration Script (Beta)

> The migration script is under active development.

Convert existing parser-based Code Connect files to template files:

```bash
npx figma connect migrate [options]
```

| Option | Description |
|---|---|
| `--outDir <dir>` | Write template files to a specific directory instead of alongside source files |
| `--javascript` | Output `.figma.js` files instead of the default `.figma.ts` |
| `--include-props` | Preserve `__props` metadata blocks in migrated output |

Migrated files use `figma.helpers` for correct rendering. You can simplify generated code when you know the exact output. For example:

```ts
// Generated (verbose)
figma.code`<Counter${figma.helpers.react.renderProp('count', count)} />`

// Simplified (manual)
figma.code`<Counter count={${count}} />`
```

### Testing in Figma

Set up a temporary config to test without affecting existing Code Connect:

```json
{
  "include": ["**/*.figma.ts"],
  "label": "TEST",
  "language": "jsx"
}
```

```bash
# Publish under temporary label
npx figma connect publish --config <your figma.config.json path>

# Remove when done
npx figma connect unpublish --config <your figma.config.json path>
```

---

## Custom Parsers

> **Note:** Custom parser support is in preview and the API is likely to change. Share feedback by [creating a GitHub issue](https://github.com/figma/code-connect/issues).

Custom parsers allow you to add Code Connect support for languages that aren't natively supported. You write Code Connect files in **any format you define**, then build a parser executable that translates them into the Template API output.

### Custom Parser Config

Custom parsers must be configured in `figma.config.json`:

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

| Field | Required | Description |
|---|---|---|
| `parser` | Yes | Must be set to `"custom"` |
| `parserCommand` | Yes | Full path or command to invoke the parser (e.g. `./tools/parser` or `node parser.js`) |
| `include` | Yes | Glob patterns for files passed to the parser during `parse` or `publish` |
| `exclude` | No | Glob patterns for files to exclude |

### Commands

#### Publish and Parse

The CLI collects all files matching `include`/`exclude`, then invokes `parserCommand` with a `ParseRequestPayload` via **stdin**. The parser outputs a `ParseResponsePayload` via **stdout**. If publishing, the CLI sends the docs to Figma.

```bash
npx figma connect publish --config figma.config.json --token <auth token>
```

#### Create

The CLI fetches the component definition from Figma, then invokes `parserCommand` with a `CreateRequestPayload` via **stdin**. The parser creates Code Connect file(s) and returns a `CreateResponsePayload` via **stdout**.

```bash
npx figma connect create "<url_to_node>" --config figma.config.json --token <auth token>
```

### How It Works Step by Step

#### Mode: PARSE

```
CLI                              Your Parser
 |                                    |
 |-- 1. Glob include/exclude ------> |
 |      to find matching files        |
 |                                    |
 |-- 2. Send ParseRequestPayload --> |  (via stdin)
 |      { mode: "PARSE",             |
 |        paths: [...],              |
 |        config: { ... } }          |
 |                                    |
 |  <-- 3. Receive ParseResponsePayload  (via stdout)
 |      { docs: [...],               |
 |        messages: [...] }           |
 |                                    |
 |-- 4. If publish: upload docs ----> Figma API
```

Your parser's job in step 3:
1. Read each file in `paths`
2. Parse them in whatever way makes sense for your language
3. For each Code Connect definition found, produce a doc object with the template, prop mappings, and metadata
4. Output the full response as JSON to stdout

#### Mode: CREATE

```
CLI                              Your Parser
 |                                    |
 |-- 1. Fetch component info ------> Figma API
 |      (props, name, type)           |
 |                                    |
 |-- 2. Send CreateRequestPayload -> |  (via stdin)
 |      { mode: "CREATE",            |
 |        destinationDir: "...",      |
 |        component: { ... } }        |
 |                                    |
 |  <-- 3. Receive CreateResponsePayload  (via stdout)
 |      { createdFiles: [...],        |
 |        messages: [...] }           |
```

Your parser's job in step 3:
1. Generate a boilerplate Code Connect file for the component
2. Write it to `destinationDir`
3. Return the list of created file paths

### Input Types

#### ParseRequestPayload

```ts
type ParseRequestPayload = {
  mode: 'PARSE'
  // Absolute paths for all files matched by include/exclude globs
  paths: string[]
  // Config options for this parser from figma.config.json
  config: Record<string, any>
}
```

#### CreateRequestPayload

```ts
type CreateRequestPayload = {
  mode: 'CREATE'
  // Absolute destination directory for the created file
  destinationDir: string
  // Optional destination file name
  destinationFile?: string
  // Filepath of the code to be connected
  sourceFilepath?: string
  // Export to use from sourceFilepath (TypeScript only)
  sourceExport?: string
  // Mapping of Figma props to code properties
  propMapping?: PropMapping
  // Information about the Figma component
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
  // Only exists on VARIANT properties
  variantOptions?: string[]
}
```

### Output Types

#### ParseResponsePayload

```ts
const ParseResponsePayload = {
  docs: {
    // Figma node URL (e.g. https://www.figma.com/design/123/MyFile?node-id=1-1)
    figmaNode: string,
    // Optional component name (display only)
    component?: string,
    // Variant restrictions keyed by Figma property name
    variant?: Record<string, string>,
    // Relative path to the component source file
    source: string,
    // Optional line number for linking
    sourceLocation?: { line: number },
    // JavaScript template function using the Template API
    template: string,
    templateData: {
      props: PropMapping,
      imports?: string[],
      nestable?: boolean,
    },
    // Language for syntax highlighting
    language: SyntaxHighlightLanguage,
    // Label for the example in the UI
    label: string,
  }[],
  messages: ParserMessage[],
}
```

#### CreateResponsePayload

```ts
const CreateResponsePayload = {
  createdFiles: {
    filePath: string, // Absolute path of the created file
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

#### Supported Syntax Highlighting Languages

`typescript` | `cpp` | `ruby` | `css` | `javascript` | `html` | `json` | `graphql` | `python` | `go` | `sql` | `swift` | `kotlin` | `rust` | `bash` | `xml` | `plaintext` | `jsx` | `tsx` | `dart`

### Example Template Implementation

A comprehensive example showing how a parser would generate a template using the Template API:

```js
const figma = require('figma')
const instance = figma.selectedInstance

// Getting property values
const stringProp = instance.getString('String Prop')
const booleanProp = instance.getBoolean('Boolean Prop')
const enumProp = instance.getEnum('Enum Prop', {
  'Option1': 'value1',
  'Option2': 'value2'
})

// Finding layers
const textLayer = instance.findText('Label')
const childInstance = instance.findInstance('Icon')
const connectedInstance = instance.findConnectedInstance('button-123')

// Using selector options
const nestedText = instance.findText('Description', {
  path: ['Container', 'Content'],
  traverseInstances: true
})

// Using selector functions
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

## Template Files vs Custom Parsers

### Key Differences

| | Template Files | Custom Parser |
|---|---|---|
| **File format** | Always `.figma.ts` / `.figma.js` | Any format you define (`.figma.dart`, `.figma.swift`, etc.) |
| **Language** | You write TypeScript/JavaScript | You write in your own DSL or language |
| **Parser needed?** | No — CLI understands it natively | Yes — you build and maintain the parser |
| **Template API** | Written directly by you | Generated by your parser as output |
| **Config `parser`** | Omitted (default) | `"custom"` |
| **Communication** | CLI reads files directly | CLI invokes parser via stdin/stdout JSON |
| **Complexity** | Lower — just write the template | Higher — build a translator layer |
| **Recommended by Figma** | Yes — actively invested as primary format | For languages where template files aren't practical |

### When to Use Which

**Use Template Files when:**
- Your team can write TypeScript (even if your components are in another language)
- You want the simplest setup with no extra infrastructure
- You want Figma's recommended, actively-supported path

**Use Custom Parsers when:**
- You want Code Connect files written in the same language as your components (e.g. `.figma.swift` alongside `.swift`)
- You want a DSL or annotation-based approach that feels native to your stack
- You're willing to build and maintain parser infrastructure

### How They Relate

Custom parsers ultimately produce the **same output** as template files. The `template` field in `ParseResponsePayload` is the same Template API JavaScript you'd write by hand in a `.figma.ts` file. The difference is **who writes that JavaScript**:

```
Template Files:   You  -->  Template API JS  -->  Figma
Custom Parser:    You  -->  Your format  -->  Your parser  -->  Template API JS  -->  Figma
```

Both approaches result in the same thing being published to Figma — the custom parser just adds an extra translation layer that you own and maintain.

> **This project** uses `"parser": "swift"` (a built-in parser maintained by Figma), which is a middle ground — you write `.figma.swift` files without needing to build the parser yourself.
