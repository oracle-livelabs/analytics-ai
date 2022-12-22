# Team Detection

<!--![Banner](images/banner.png)-->

## Introduction

Players are either from team A or team B. How can we recognize for which team they are playing? We’ll choose a rather straightforward approach, by looking at the color of their shirts. We’ll use the .inRange and .bitwise functions of the OpenCV library to do this. We will simply count the number of “red” versus “green” pixels that were detected in the bounded rectangle that is the player.
This works rather well, but it has the disadvantage that we have to manually set the team colors anytime we look at a new match. For now, this is good enough, and in the future we could explore better mechanisms to do this, e.g. through clustering.

<!-->

“Now you have each player extracted out. We need to read the color of their jersey to predict if they are an Australian player or a Peru player. This is done by the code block detect team. We first define the color ranges for red and blue colors. Then we use cv2.inRange and cv2.bitwise to create a mask of that color. To detect team, I count how many red pixels and yellow pixels were detected and what is the percent of that compared to total num of pixels in the cropped image.”

Estimated Time: 15 minutes

### Objectives
- Use the prebuilt model to recognize the players and the ball. We will do this on one single frame (image) of the video.
- Learn how to use OCI Data Science and OCI Vision together.

### Prerequisites
- Oracle Analytics Cloud
- Autonomous Data Warehouse
- You've completed the previous lab that loads the data sources into the Autonomous Data Warehouse
-->

You may now proceed to the next lab.

## Acknowledgements
* **Authors** - Olivier Perard - Iberia Technology Software Engineers Director, Jeroen Kloosterman - Product Strategy Director
