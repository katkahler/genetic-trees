//fyi, different screen size will affect visibility of first few generations

class Tree {

  float[] variables = new float[7]; //array of values to determine tree properties
  float branchLength, branchWidth, branchQuan, leafColor, leafSize, branchAngle; //all of the variables controlling the tree's properties

  Tree() {
    for (int i = 0; i < variables.length; i++) {
      variables[i] = random(1); //randomizes the values between 0-1
    }
  }

  void grow(float base_case) {
    branchLength = (variables[0] * 30) + 20; //adjusting the values between 0-1 so they are useful in their respective ways, without changing the actual value between 0-1
    branchWidth = (variables[1] * 15) + 5;
    branchQuan = round(variables[2] * 3) + 2 ; 
    leafColor = (variables[3] * 255) + 25;
    leafSize = (variables[4] * 20) + 5;
    branchAngle = (variables[5] * 5) + 3;

    if (base_case > 0) {
      stroke(0);
      strokeWeight((branchWidth * (base_case/1.5))/7); //changing the branch width

      line(0, 0, 0, -(branchLength * base_case )); //drawing the branches with regard to branch length

      if (base_case <= 4) { //draws a leaf, using the leafColor and leafSize variables
        strokeWeight(2);
        pushMatrix();
        translate(0, -(branchLength * base_case ));
        fill(0, leafColor, 0);
        ellipse(0, 0, leafSize * base_case, (leafSize * base_case)/2);
        popMatrix();
      }

      //println(branchLength, branchWidth, branchQuan, leafColor, leafSize, base_case);

      base_case = base_case - 1; //lowers the base case

      //recursive process of creating new branches, with regard to branch quantity and branch angle
      for (float i = 0; i < branchQuan; i++) {

        if (base_case >= 4) {
          pushMatrix();
          translate(0, -(branchLength * base_case));
          if (i == 0) {
            rotate((PI)/branchAngle);
            grow(base_case);
          }
          if (i == 1) {
            rotate((-1*PI)/branchAngle);
            grow(base_case);
          }
          if (i == 2) {
            rotate((0*PI)/branchAngle);
            grow(base_case);
          }
          if (i == 3) {
            rotate((-0.5*PI)/branchAngle);
            grow(base_case);
          }
          if (i == 4) {
            rotate((0.5 * PI)/branchAngle);
            grow(base_case);
          }
          popMatrix();
        } else { //prevents lag by only allowing two branches at the end of the tree
          pushMatrix();
          translate(0, -(branchLength * base_case));
          if (i == 0) {
            rotate((PI)/branchAngle);
            grow(base_case);
          }
          if (i == 1) {
            rotate((-1*PI)/branchAngle);
            grow(base_case);
          }
          popMatrix();
        }
      }
    }
  }

//the breeding process
  Tree breed(Tree other) {

    Tree seed = new Tree();

    for (int i = 0; i < variables.length; i++) {
      
//breeding based on dominant tree (weighted probability)
      seed.variables[i] = random(this.variables[i], other.variables[i]);
      seed.variables[i] = random(dominant.variables[i], seed.variables[i]);

//implementing mutations and printing where the mutation was done. One if statement per variable in variables[]
      if (round(random(10)) == 5) {
        if (i == 0) {
          seed.variables[i] = seed.variables[i] * random(0.25, 1.25);
          println("Mutation! (Branch Length)");
        }
        if (i == 1) {
          seed.variables[i] = seed.variables[i] * random(0.25, 1.25);
          println("Mutation! (Branch Width)");
        }
        if (i == 2) {
          seed.variables[i] = seed.variables[i ]* random(2);
          println("Mutation! (Branch Quantity)");
        }
        if (i == 3) {
          seed.variables[i] = seed.variables[i] * random(0.5, 1.25);
          println("Mutation! (Leaf Color)");
        }
        if (i == 4) {
          seed.variables[i] = seed.variables[i] * random(0.5, 1.25);
          println("Mutation! (Leaf Size)");
        }
        if (i == 5) {
          seed.variables[i] = seed.variables[i] * random(0.75, 1.25);
          println("Mutation! (Branch Angle)");
        }
      }
    }
//returning the mutated tree
    return seed;
  }
}

//dominant tree based off user input 
Tree dominant;
float generation = 1;

//arraylist keeps drawing trees
ArrayList<Tree> trees= new ArrayList<Tree>();

void setup() {
  size(1000, 1000);
  println("Do you prefer Tree A or Tree B?");
  //starting with two random trees
  trees.add(new Tree());
  trees.add(new Tree());
}

//translation and scale based off of how many trees are on the screen
void draw() {
  pushMatrix();
  background(255);
  translate(100, 850);
  //stopping the scale after three generations are on screen
  if (generation <= 3) {
    scale(1/generation);
  } else {
    scale(1/3.0);
  }
  
  //telling the trees to grow and translating after every tree/generation
  pushMatrix();
  for (int i = 0; i < trees.size(); i++) {
    pushMatrix();
    translate(i/6 * - 2700, i/6 * -625);
    Tree a = trees.get(i);
    a.grow(6);
    popMatrix();
    translate(450, 0);
  }
  popMatrix();
  popMatrix();
}

//if key a is pressed, the first tree becomes the dominant tree, and the breeding process occurs
void keyReleased() {
  if (int(key) == char(97)) {
    println("OK!");
    dominant = trees.get(trees.size()-2);
    Tree seed1 = trees.get(trees.size()-2).breed(trees.get(trees.size()-1));
    Tree seed2 = trees.get(trees.size()-1).breed(trees.get(trees.size()-2));

//asking the question again to breed another generation
    println("Do you prefer Tree A or Tree B?");
//adding the kid trees to the arraylist
    trees.add(seed1);
    trees.add(seed2);
    generation = generation + 1;
  }

//if key b is pressed, the second tree becomes the dominant tree, and the breeding process occurs
  if (int(key) == char(98)) {
    println("OK!");
    dominant = trees.get(trees.size()-1);
    Tree seed1 = trees.get(trees.size()-2).breed(trees.get(trees.size()-1));
    Tree seed2 = trees.get(trees.size()-1).breed(trees.get(trees.size()-2));

//asking the question again to breed another generation
    println("Do you prefer Tree A or Tree B?");
//adding the kid trees to the arraylist
    trees.add(seed1);
    trees.add(seed2);
    generation = generation + 1;
  }
}
