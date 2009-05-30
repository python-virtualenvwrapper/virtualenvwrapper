"""virtualenvwrapper module
"""

if __name__ == '__main__':
    import os
    import webbrowser
    docs_root = os.path.join(os.path.dirname(__file__), 'docs', 'index.html')
    webbrowser.open_new('file://' + docs_root)
else:
    import warnings
    warnings.warn('Use virtualenvwrapper_bashrc to set up your shell environment.')
