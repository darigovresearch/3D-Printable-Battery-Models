$inner_diameter = 18.5/2; //Radius of batter wall (mm)

$battery_offset = 1;

$endcap_height = 10;

$endcap_width = 3;

$number_of_batteries = 1;

$tolerence = 0.2;

$endcap_top = 1;

$peg_width = 4;

//$number_of_fragents = 45;
$number_of_fragents = 90;

module reference_battery($fn = $number_of_fragents) {
    // reference stethoscope head as it was too complex to load into memory
    cylinder(h = 65, r = $inner_diameter);

}

module keyway(width, height, waist, depth){
    // keyway is code to handle making a keyway to easily switch out addons

//    rotate(a = 90, v = [0, 1, 0]){
        linear_extrude(height = depth, center = true)
        polygon(points = [
                [-width/2, -height/2],
                [0, -waist/2],
                [width/2, -height/2],
                [width/2, height/2],
                [0, waist/2],
                [-width/2, height/2]]
        );
//    }
}


module connector(width) {

//    cube([width, width, $endcap_height], center = true);
    keyway(width, 2*width, 2*width-2, $endcap_height);
}

module cap($fn = $number_of_fragents) {

    translate(v = [($inner_diameter + $endcap_width), 0, $endcap_height/2]){
        connector($peg_width - $tolerence);
    }

    rotate([0, 0, 90]) {
        translate(v = [($inner_diameter + $endcap_width), 0, $endcap_height/2]){
            connector($peg_width - $tolerence);
        }
    }

    // the cap itself

    difference() {
      difference() {
          difference() {
              translate(v = [0, 0, $endcap_height/2]){
                  cube([2*($inner_diameter + $endcap_width), 2*($inner_diameter + $endcap_width), $endcap_height], center = true);
              }

              translate(v = [0, 0, $endcap_top*2]){
                  cylinder(h = $endcap_height*3, r =  $inner_diameter + $tolerence/2);
              }
          }

  //        translate(v = [0, 0, $endcap_top]){
              cylinder(h = $endcap_height*3, r =  $inner_diameter*0.8 + $tolerence/2);
  //        }
       }

      union() {

        rotate([0, 0, 180]) {
          translate(v = [($inner_diameter + $endcap_width), 0, $endcap_height/2]){
            connector($peg_width);
          }
        }

        rotate([0, 0, 270]) {
          translate(v = [($inner_diameter + $endcap_width), 0, $endcap_height/2]){
            connector($peg_width);
          }
        }
      }
    }
}


for (a =[0:1:$number_of_batteries - 1]){
    echo(a);
    translate(v = [a*($inner_diameter*2 + $endcap_width*2 + $tolerence), 0, 0]){

//        reference_battery();
        cap();
    }
}
