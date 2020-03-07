// Title: Wedge Triangle Module
// Author: Carlo Wood
// Date: 19/8/2016
// License: Creative Commons - Share Alike - Attribution

// Usage: Include in your other .scad projects and call wedge with arguments for the height
//        of the wedge, two of the legs of the wedge, and the angle between those legs.
//        The resulting wedge will be placed with the point at the origin, `leg1' along the x-axis
//        and extending `height' into the z axis, with the angle starting at the x axis and
//        extending counter-clockwise as per the right-hand rule towards `leg2`.


//           Y-axis
//           |
//           |  /\
//      leg2 --/  \
//           |/    \
//           /)_____\_______X-axis
//     angle--'  \__ leg1
//
module wedge(angle, leg1, leg2, height = 0.5)
{
  // Store the length of all three sides in an array.
  side = [sqrt(leg1 * leg1 + leg2 * leg2 - 2 * leg1 * leg2 * cos(angle)),	// Law of Cosines.
          leg1,
          leg2];

  i = (leg2 > leg1) ? 2 : 1;
  longest_leg = side[i];
  longest_side = (side[0] > longest_leg) ? side[0] : longest_leg;

  // The corner opposite of the shortest leg must be less than 90 degrees.
  sa = asin(side[3 - i] * sin(angle) / side[0]);		// Law of Sines.
  sb = 180 - angle - sa;					// Sum of all angles is 180 degrees.

  // Store the size of all three angles in an array.
  a = [angle, (i == 1) ? sb : sa, (i == 1) ? sa : sb];

  // Is there anything to draw at all?
  if (angle > 0 && angle < 180)
  {
    intersection()
    {
      if (angle <= 90)
	intersection()
	{
	  cube([longest_leg, longest_leg, height]);
	  rotate([0, 0, angle - 90])
	    cube([longest_leg, longest_leg, height]);
	}
      else
	union()
	{
	  cube([longest_leg, longest_leg, height]);
	  rotate([0, 0, angle - 90])
	    cube([longest_leg, longest_leg, height]);
	}
      if (a[2] < 90)
      {
	translate([leg1, 0, 0])
	  rotate([0, 0, 90 - a[2]])
	    translate([-longest_side, 0, 0])
	      cube([longest_side, longest_side, height]);
      }
      else
      {
        rotate([0, 0, angle])
	  translate([leg2, 0, 0])
	    rotate([0, 0, a[1]])
	      translate([-longest_side, 0, 0])
	        cube([longest_side, longest_side, height]);
      }
    }
  }
}

// Example: wedge(145, 10, 20, 5); // Would create a triangle with thickness 5 where two legs,
                                   // being 10 and 20 respectively, making an angle of 145 degrees,
				   // the point on the z-axis and leg1 along the x-axis.

