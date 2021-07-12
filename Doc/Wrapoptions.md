JoberGen currently supports the following wrap options for maps:

# NONE

The `NONE` wrap option means the map is a square bounded both in
the north-south direction and east-west direction.  On all four
sides of the map, there is an edge which can not be crossed.

An ASCII diagram:

```
** ** ** ** ** ** **
** 15 25 35 45 55 **
** 14 24 34 44 54 **
** 13 23 33 43 53 **
** 12 22 32 42 52 **
** 11 21 31 41 51 **
** ** ** ** ** ** **
```

Here, each number is an (X,Y) pair and anything marked `**` can not be
crossed.

# TORIC

The `TORIC` wrap option means the map is finite but not bounded.  At
no point on the map is there an edge which can not be crossed.

The map wraps around in both directions: The east-west direction and
the north-south direction.

Instead, when the player reaches the west edge of the map, any futher
move west puts them on the east edge of the map.  Likewise, any move
east from the east edge puts them on the west edge.

The same is true on the north and south edges: Any further move north 
at the north edge of the map places one on the south edge of the map;
any further move south at the south edge places one on the north edge
of the map.

An ASCII diagram:

```
51 11 21 31 41 51 11
55 15 25 35 45 55 15
54 14 24 34 44 54 14
53 13 23 33 43 53 13
52 12 22 32 42 52 12
51 11 21 31 41 51 11
55 15 25 35 45 55 15
```

# WRAPX

This is a combination of the `NONE` and `TORIC` map options: The 
East-West edge wraps around (going west of the west edge puts one
on the east edge; going east on the east edge puts one on the west 
edge), but the north and south edges can not be crossed.

An ASCII diagram:

```
** ** ** ** ** ** **
55 15 25 35 45 55 15
54 14 24 34 44 54 14
53 13 23 33 43 53 13
52 12 22 32 42 52 12
51 11 21 31 41 51 11
** ** ** ** ** ** **
```

# WRAPY

This is the opposite of the `WRAPX` map option: The west edge and
the east edge can not be crossed, but going north at the north edge
puts one on the south edge of the map, and going south at the south
edge puts one on the north edge of the map.

This wrap option is sometimes called a “Uranus” map, since Uranus 
spins vertically.

An ASCII diagram:

```
** 11 21 31 41 51 **
** 15 25 35 45 55 **
** 14 24 34 44 54 **
** 13 23 33 43 53 **
** 12 22 32 42 52 **
** 11 21 31 41 51 **
** 15 25 35 45 55 **
```

# SEMISPHERE

This is an attempt to be in the same general topological class as
a sphere, while minimizing the issues one has when tiling a sphere.

The west and east edges wrap around the same way they do in `TORIC`
and `WRAPX` maps.

The north edge can be crossed, but when one crosses the north edge,
they end up halfway across the world on the north edge.  This is
a reasonable simulation of crossing the north pole.  The south edge works
the same way.

An semisphere map must have an even X size.

An ASCII diagram:

```
34 44 54 64 14 24 34 44
35 45 55 65 15 25 35 45 
65 15 25 35 45 55 65 15
64 14 24 34 44 54 64 14
63 13 23 33 43 53 63 13
62 12 22 32 42 52 62 12
61 11 21 31 41 51 61 11
31 41 51 61 11 21 31 41
32 42 52 62 12 22 32 42
```

Note that, if this wrapping option were to be played in a game, once
one crosses the north pole or south pole, one could be in a vertically
flipped mirror image of the map until one crossed a pole again (or the
game may, after one crosses a pole, tell the player they have crossed a
pole and teleport them back to a non-flipped version of the map).

This topological space locally resembles Euclidean (normal) space at
each point: All points on the map are squares which allow movement 
in eight directions.

# Other possible spaces

It would be possible to make a semi-Uranus wrap option, where north-south
wrap, but going to the east or west edge would place one elsewhere
on the east/west edge; this optional would locally resemble Euclidean
space at all points of the map.  This has not been implemented.

Likewise, a semi-sphere or semi-Uranus map where it’s not possible
to go past the west or east edge (north/south with the Uranus version)
could also be, but has not been, implemented.

It’s not possible to make a semi-sphere variant where we go back to a
different place on the same edge for all four edges without making the
map non-Euclidean at the corners of the map.  Since going diagonally NW
at the top left is not defined, we would have to forbid a single diagonal
move at this location; the same is true for the other three corners of the
map. The map would have four special squares (one for each corner) which 
act differently than other locations on the map.

# Tiling a sphere

As it turns out, it’s not possible to tile a sphere such that each tile is
locally Euclidean.  The standard geodisk tilings would *mainly* be hexagons,
but the tiling would need to have (choose one) four triangles, eight squares,
or 12 pentagons.  Other ways of simulating a sphere are possible, but
remain non-Euclidean at some point; e.g. having the map on a cube has 24
squares with non-Euclidean behavior (three squares at each corner).
