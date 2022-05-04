# example

Hi! My flutter application used Karee library

## Getting Started


- ### Setup Flutter Evironment
    [How to Setup Flutter](https://flutter.dev)

- ### install Karee-CLI
  ```bash
      npm install -g karee
  ```
- ### Clone the main repo
    ```bash
        git clone "https://github.com/ChamplainLeCode/karee"
        
        cd karee/example
    ```
- ### How to run

  To run this project in development mode, you should run karee code generator tool, then use you favorite IDE to run flutter project, or simply run **flutter run** command
  to run **Karee code generator** use 
    ```bash
      karee source
    ```

  alternatively you can use flutter command to run code generator
    ```bash
    flutter clean && flutter pub get && flutter packages pub run build_runner watch --delete-conflicting-outputs
    ```