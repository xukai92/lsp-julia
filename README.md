# lsp-julia

Julia support for the [`lsp-mode`](https://github.com/emacs-lsp/lsp-mode)
package using the
[LanguageServer.jl](https://github.com/JuliaEditorSupport/LanguageServer.jl)
package. For information on the features `lsp-mode` provides see their
[git repository](https://github.com/emacs-lsp/lsp-mode).

*A julia version == 0.6.x has to be in your path*

_This package is still under development._

## Installation
### Installing the Julia Language Server
Open a Julia REPL and install LanguageServer.jl.

```julia
julia> Pkg.add("LanguageServer")
```

Additionally because JIT compilation of LanguageServer.jl can cause a long delay
which may cause issues with lsp-mode, I recommend using
[PackageCompiler.jl](https://github.com/JuliaLang/PackageCompiler.jl) to AOT
compile LanguageServer.jl into your julia image. Something like:

```julia
julia> Pkg.add("PackageCompiler")
julia> using PackageCompiler
julia> compile_package("LanguageServer")
```

See the documentation on PackageCompiler.jl for further usage details.

### Installing `lsp-julia`

It's currently easiest to install this package with quelpa. I'll see about
getting this added to melpa soon enough.

```emacs-lisp
(quelpa '(lsp-julia :fetcher github :repo "non-Jedi/lsp-julia"))
```

### Using `lsp-julia` with a julia major mode

After installing the major mode of your choice for editing Julia files
([julia-mode](https://github.com/JuliaEditorSupport/julia-emacs),
[ess](https://ess.r-project.org/), etc.), add `'lsp-mode` to the hook for that
major mode. For example, to use `lsp-julia` with ess, add the following to your
`.emacs` file:

```emacs-lisp
(add-hook 'ess-julia-mode-hook #'lsp-mode)
```

Please don't hesitate to open an issue in case of problems or create a PR. 
