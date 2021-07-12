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
the east edge can not be crossed, but going north at the noth edge
puts one on the south edge of the map, and going south at the south
edge puts one on the north edge of the map.

This wrap option is sometimes called a “Uranus” map, since Uranus 
spins north-to-south.

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
a reasonble simulation of crossing the north pole.  The south edge works
the same way.

An semisphere map must have an even X size.

An ASCII diagram:

```
35 45 55 65 15 25 35 45 
65 15 25 35 45 55 65 15
64 14 24 34 44 54 64 14
63 13 23 33 43 53 63 13
62 12 22 32 42 52 62 12
61 11 21 31 41 51 61 11
31 41 51 61 11 21 31 41
```

Note that, if this wrapping option were to be played in a game, once
one crosses the north pole or south pole, one could be in a vertically
flipped mirror image of the map until one crossed a pole again (or the
game may, after one crosses a pole, tell the player they have crossed a
pole and teleport them back to a non-flipped version of the map).

