# prospector-check

GitHub Action for [prospector](https://prospector.readthedocs.io/en/master/)

Make sure you have a `.prospector.yaml` file at the root of your repository!

## Inputs

### `prospector_flags`

**Optional** Optional prospector flags (refer to `prospector --help`)

**Default** `""`

## Outputs

None

## Example usage

```yaml
uses: jpetrucciani/prospector-check@master


# or pass additional flags!
uses: jpetrucciani/prospector-check@master
with:
  prospector_flags: "--without-tool pyroma"
```
