/*

A base for the Raspberry Pi, with attachment holes to mount on an optical table

*/

$fs = 0.2;
$fa = 0.2;

//dimensions of the raspberry pi
pi_width = 56;
pi_length = 85;

//how much the base protrudes from the raspberry pi body
extra_width = 25;
extra_length = 35;

//actual dimensions of the base
total_width = pi_width + extra_width*2;
total_length = pi_length + extra_length*2;
thickness = 4;

//screw dimensions
inner_r = 1.5;
outer_r = 3;
cone_r = 5;

hole_separation_length = 58;
hole_separation_width = 56-3-3-0.5-0.5;

//location of the four holes
hole_x = extra_width + 3 + 0.5;
hole_y = extra_length + 3 + 0.5;
feet_height = 2.5;
hole_height = thickness+feet_height+2;

//location of the four attachment holes
separation = 25.4;
attachment_x = total_width/2 - (separation/2 +separation*1);
attachment_y = total_length/2 - (separation/2 + separation*2);

module foot(){
    cylinder(r=outer_r,h=feet_height);
}
module screw_hole(){
    cylinder(r=inner_r,h=hole_height);
}
module cone_hole(){
    cylinder(r1=cone_r, r2=inner_r,h=thickness);
}
module attachment_hole(){
    cylinder(r=3.2,h=thickness+2);
}

//cutout dimensions
margin = 10;
cutout_x = hole_separation_width-cone_r*2-margin;
cutout_y = extra_length+margin;
module sd_cutout(){
    translate([total_width/2,cutout_y/2-0.01,thickness/2-1]) cube([cutout_x,cutout_y,thickness+3],center=true);
}

module move_raspi_bolts(){
    translate([hole_x,hole_y,0]) children();
    translate([hole_x,hole_y+hole_separation_length,0]) children();
    translate([hole_x+hole_separation_width,hole_y+hole_separation_length,0]) children();
    translate([hole_x+hole_separation_width,hole_y,0]) children();
}

module move_attachment_bolts(){
    translate([attachment_x, attachment_y,-1]) children();
    translate([total_width-attachment_x, attachment_y,-1]) children();
    translate([attachment_x, total_length-attachment_y,-1]) children();
    translate([total_width-attachment_x, total_length-attachment_y,-1]) children();
}

difference(){
    //base with legs
    union(){
        cube([total_width,total_length,thickness]);
        translate([0,0,thickness]) move_raspi_bolts() foot();
    }
    
    //subtract holes from screws
    translate([0,0,-0.001]) move_raspi_bolts(){
        screw_hole(); 
        cone_hole();
    }
    
    //subtract holes for attachment (to the optical table) bolts
    move_attachment_bolts(){
        attachment_hole();
    }
    
    sd_cutout();
}