# Simple dart web widgets

A library of very simple Web-components on dart. Not compatible with Flutter. 

Read in other languages: [English](README.md), [Русский](README.ru.md).

Live showcase example: [simple_dart_web_showcase](https://viktorzahar.github.io/simple_dart_web_showcase)

##The main principles of the library

- OOP approach
- The components should be simple, flexible and suitable for customization in each individual project.
- No magic (no code generation, no React programming, no DI, etc.).

## Separation for css and code
- Theme is defined in one CSS file.
- System styles are extracted in the system_style.css file.

### Component properties defined in the theme (via CSS)
- font
- background
- color
- border
- font
- images
- padding (for components)

### Component properties defined in dart code
- stride
- width
- height
- vertical
- wrap
- align
- scrollable
- fillContent
- padding (for panels)

### Names conventions
- The names of all CSS classes begin with a capital letter and correspond to the class names in Dart.

## Panel
- There is only one component for composition in the library - the Panel class. Using a combination of panels, you can create any layouts.
- Panel - is not intended to be inherited from it. 
- To create new panel-based components, use the abstract PanelComponent class. As a parameter, you need to pass the name of the new dart class.

Example:

    class SomeNewComplexComponent extends PanelComponent {
        SomeNewComplexComponent(): super('SomeNewComplexComponent') {
            vertical = true;
            ...
        }
    }

- Simple components that do not need composition are inherited from the Component class. You also need to pass the name of the new dart class as a parameter.

Example:

    class SomeNewComponent extends Component {
        SomeNewComponent(): super('SomeNewComponent') {

        }

        @override
        Element nodeRoot = DivElement();
    }

All components have a nodeRoot - which is placed in the DOM. Is possible access to the component style using nodeRoot.style - but only in emergency cases or during development.

### Auxiliary CSS classes

- Active - highlights the active state of the component (for example, the current tab or a clamped button).
- Disabled - highlights the disabled state of the component.

These classes are used only in MixinActivate and MixinDisable mixins - if you need to add activability or a ban on editing to your components, just mix these mixins into your new component.

### Examples of using the library:
For checking the appearance of themes, exist project: [simple_dart_web_showcase](https://github.com/ViktorZahar/simple_dart_web_showcase)

For create single page applications, it is recommended to use the library: [simple_dart_web_views](https://github.com/ViktorZahar/simple_dart_web_views)