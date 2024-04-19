# インタプリタ演習 Week 1：サンプルコード

## ビルド方法

```console
dune build
```

## 実行方法

```console
dune exec example
```

たとえば

```console
$ echo "1 + 2" | dune exec example
EBin (OpAdd,1,2)
```

## 備考

`dune utop`を有効に使うために`main.ml`以外をライブラリとして分離したほうがよいかもしれない．

ただ作業としては`main.ml`を分離したほうが楽である．
具体的には`app`というディレクトリを作成し，そこに`main.ml`をコピーし，一行目に

```ocaml
open Mylib
```

を付け加える．また，`app/dune`というファイルを以下の内容で作成する．

```
(executable 
 (public_name example)
 (libraries mylib)
 (name main))
```

そして，`src/dune`の内容を以下に変更する．

```
(ocamllex
 (modules lexer))

(menhir
 (modules parser))

(library
 (name mylib))
```

ディレクトリ構成は以下のようになるはず．

```text
.
├── README.md
├── dune-project
├── example.opam
├── src
│   ├── dune
│   └── main.ml
└── src
    ├── dune
    ├── lexer.mll
    ├── main.ml
    ├── parser.mly
    └── syntax.ml
```