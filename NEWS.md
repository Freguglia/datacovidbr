# datacovidbr 0.0.4

* Added new source from https://transparencia.registrocivil.org.br/registral-covid available at `registro_civil()`.

# datacovidbr 0.0.3

* `brMinisterioSaude()` rewritten because old source no longer works.

# datacovidbr 0.0.2

* Added a `NEWS.md` file to track changes to the package.
* `CSSEGISandData()` now keeps `Lat` and `Long` columns. 
The `by_country` argument controls whether data should be summarised (sum)
by country over the `Province.State` variable. In this case, `Lat` and `Long`
are averaged over all `Province.State` values.
* All functions now read data in `UTF-8` format to avoid encoding problems in
Windows systems.