# test-ocaml


[![CircleCI](https://circleci.com/gh/yourgithubhandle/test-ocaml/tree/master.svg?style=svg)](https://circleci.com/gh/yourgithubhandle/test-ocaml/tree/master)


**Contains the following libraries and executables:**

```
test-ocaml@0.0.0
│
├─test/
│   name:    TestTestOcaml.exe
│   main:    TestTestOcaml
│   require: test-ocaml.lib
│
├─library/
│   library name: test-ocaml.lib
│   namespace:    TestOcaml
│   require:
│
└─executable/
    name:    TestOcamlApp.exe
    main:    TestOcamlApp
    require: test-ocaml.lib
```

## Developing:

```
npm install -g esy
git clone <this-repo>
esy install
esy build
```

## Running Binary:

After building the project, you can run the main binary that is produced.

```
esy x TestOcamlApp.exe 
```

## Running Tests:

```
# Runs the "test" command in `package.json`.
esy test
```
