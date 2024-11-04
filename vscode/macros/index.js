const vscode = require('vscode')

/**
 * Macro configuration settings
 * { [name: string]: {              ... Name of the macro
 *    no: number,                   ... Order of the macro
 *    func: ()=> string | undefined ... Name of the body of the macro function
 *  }
 * }
 */
module.exports.macroCommands = {
   PythonImports: {
      no: 1,
      func() {
         const editor = vscode.window.activeTextEditor;
         if (!editor) {
            // Return an error message if necessary.
            return 'Editor is not opening.';
         }
         const document = editor.document;
         if (document.languageId != "python") return

         let firstImportLine = 0
         for (let i = 0; i < document.lineCount; i++) {
            const line = document.lineAt(i)
            const text = line.text.trimStart()
            if (text.startsWith("import ") || text.startsWith("from ")) {
               firstImportLine = i
               break
            }
         }

         // vscode.workspace.fs.stat(vscode.Uri.)
         editor.edit(editBuilder => {
            editBuilder.insert(new vscode.Position(firstImportLine, 0), "import os\n")
         })
      }
   }
}
