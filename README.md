# Godot Package Manager

[![Chat on Discord](https://img.shields.io/discord/853476898071117865?label=chat&logo=discord)](https://discord.gg/6mcdWWBkrr)

A package manager for Godot 3.x. [NPM](https://www.npmjs.com/) allows for arbitrary
packages to be uploaded, so why not upload Godot addons there to be automatically
managed?

### Note
This addon itself has an implicit dependency on [advanced-expression-gd](https://github.com/you-win/advanced-expression-gd),
which will be automatically pulled before pulling other dependencies.

## Using Packages Quickstart
1. Clone the repository or [grab the latest release](https://github.com/you-win/godot-package-manager/releases)
2. Place the `addons/godot-package-manager` folder into your project's `addons` directory
3. Enable the plugin in Godot. A new menu will appear in the editor's bottom panel
4. Find some [Godot packages on NPM](https://www.npmjs.com/search?q=keywords:godot)
5. Add them to the `godot.package` file [(See the `godot.package` section)](#godotpackage)
6. Press the `Update` button in the plugin's UI to start pulling packages

## Publishing Packages Quickstart
1. Download the [npm cli tool](https://github.com/npm/cli)
2. Copy your `README.md` and `LICENSE` files into the addon folder (if you don't have these, you should create them)
3. In your addon folder, run `npm init` or `npm init --scope=<your scope>` (e.g. given `addons/my_plugin/`, run these commands in the `my_plugin` folder)
4. Answer the prompts given by `npm`
5. Run `npm publish --access public ` to publish your package. [See the npm docs for more details](https://docs.npmjs.com/creating-and-publishing-scoped-public-packages)

## `godot.package`
Describes packages to be installed along with run hooks. This _should_ be modified
by the user.

Note: unrecognized fields will be ignored. This can be useful for storing additional data or notes.

```JSON
{
    "packages": {
        "simple_package_name": "version_string",
        "complex_package_name": {
            "version": "version_string",
            "required_when": "script_body",
            "optional_when": {
                "type": "script|script_name",
                "value": "
                    non compliant json string
                    but godot still parses this correctly
                        tabs are normalized and preserved
                            so this is also valid
                "
            }
        }
    },
    "hooks": {
        "pre_update": "script_body",
        "post_update": {
            "type": "script|script_name",
            "value": "string"
        },
        "pre_dry_run": [
            "json",
            "compliant",
            "multiline",
            "script_body",
            "tabs must be inserted explicitly",
            "\t"
        ],
        "post_dry_run": "
            non compliant json string
            but godot still parses this correctly
                tabs are normalized and preserved
                    so this is also valid
        ",
        "pre_purge": "...",
        "post_purge": "..."
    },
    "scripts": {
        "script_name": "script_body",
        "other_script": "
            non compliant json string
            but godot still parses this correctly
                tabs are normalized and preserved
                    so this is also valid
        "
    }
}
```

### Notes
* All scripts and expressions are passed the containing `GodotPackageManager` as `gpm` as a function parameter
* Multi-line strings __are__ supported even though this is technically invalid JSON

## `godot.lock`
Keeps track of currently installed packages.

This is auto-generated by the addon and should not be modified manually.

```JSON
{
    "package_name": {
        "version": "version_string",
        "integrity": "sha_string"
    }
}
```

## To Do
* Handle packages with dependencies on other Godot packages
* Automatically add packages listed in `godot.lock` to the user's `.gitignore`
* Standalone app
