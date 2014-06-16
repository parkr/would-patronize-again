# Would Patronize Again

Cool places I went in the cities I've visited that I'd go to again.

## Usage

Go to the `cities/` folder and browse your favourite city!

## Adding a New Location

There are 2 scripts which aid in the addition of locations: `script/new`
and `script/geocode`. The former adds the feature to the geojson for the
right city, whereas the latter looks up the address's latitude, longitude,
address, and city You can combine them like this:

```bash
script/new \
    --name 'Aufsturz' \
    --marker bar \
    $(script/geocode Oranienburger Straße 67 10117 Berlin)
```

... or just use `script/new` on its own ...

```text
script/new \
    --name 'Aufsturz' \
    --marker bar \
    --lat 52.52502 \
    --lon 13.39195 \
    --address 'Oranienburger Straße 67, 10117 Berlin, Germany' \
    --city Berlin
```

### `script/new`

```text
Usage:

  script/new <city> [options]

Options:
        -n, --name NAME      The name of the establishment
        -m, --marker SYMBOL  The marker symbol for the establishment
        -a, --address ADDR   The address of the establishment
        -c, --city CITY      The city to add this establishment to
        -L, --lat COORD      The latitude of the establishment
        -l, --lon COORD      The longitude of the establishment
```

### `script/geocode`

```text
Usage:

  script/geocode <address>
```

## License

This repository was written and is maintained by Parker Moore (@parkr on GitHub).

The code is licensed under the MIT license as detailed in `LICENSE_code`.
The data is licensed under the  CC0 1.0 Universal license as detailed in `LICENSE_data`.
