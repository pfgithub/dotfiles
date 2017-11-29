# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"


replacements = atom.config.get 'conceal.replacements'
atom.config.observe 'conceal.replacements', (newValue) ->
  replacements = newValue

atom.workspace.observeTextEditors (editor) ->
  editor.onDidStopChanging ->
    view = atom.views.getView editor
    return unless view

    for element in view.querySelectorAll '.line span:not(.syntax--concealed)'
      replacement = replacements[element.textContent]
      #continue unless replacement
      continue unless replacement and (typeof replacement is 'string')

      element.classList.add 'syntax--concealed'
      element.dataset.replacement = replacement
      unless atom.config.get 'conceal.preserveWidth'
        element.dataset.replacementLength = replacement.length
