import 'dart:io';

//Bonita, Ireneo III    BSCS 3A - Semifinals Project
//Credits to My Bro for Giving feedbacks
void main() {
  List<String?> name = List.filled(80, null);
  name[3] = 'Ben';
  print("Welcome to Mathilda Airlines!");
  //Array containing the number of available seats. Declared outside of booking operation functions to allow them to access it without discrimination.
  var avai = [];

  void checkSeats() {
    avai = []; //Empty the available seats array every new update.

    for (int x = 0; x < name.length; x++) {
      if (name[x] == null) {
        avai.add(x + 1);
      }
    }
    print("The seats available are $avai");
  }

  checkSeats();

  void bookFlight() {
    print("The seats available are $avai"); //Display available seats
    print(
        "Which seat do you want to occupy?"); //Ask passenger which seat to occupy

    int? n = int.parse(stdin.readLineSync()!); //The necessary prompt

    if (name[n - 1] != null) {
      //If the seat happens to be taken, reiterate the booking function.
      print("THAT SEAT IS TAKEN!");
      bookFlight();
      return null;
    } //Else, proceed.

    //Ask for passenger's name then place them on the seat.
    print("You will be occupying seat $n for this flight. Name please.");
    name[n - 1] = stdin.readLineSync();
    print("Booking Successful!\n");

    //Notification then Seat checking to prepare for next passenger/operation.
    checkSeats();
  }

  void cancelReservation() {
    //Ask for the name of the passenger.
    print("You have opted to cancel your reservation.\nName please.");

    //The necessary prompt that asks for name of passenger whose reservation will be removed.
    String? nem = stdin.readLineSync();

    for (int s = 0; s < name.length; s++) {
      //If the seat is found. the entry is terminated. Else, nothing happens which is not important.

      if (name[s] == nem) {
        name[s] = null;
        print("RESERVATION CANCELLED");
        break;
      }
    }

    checkSeats();
  }

  void changeSeats() {
    int q = -1; //Placeholding variable. Originally the name doesn't exist.
    print("You have opted to change seats. Name please");
    String? nem = stdin.readLineSync(); //Ask for the name of the passenger.

    //See if the name exists in the list
    for (int s = 0; s < name.length; s++) {
      if (name[s] == nem) {
        q = s;
        //Store seat information in variable q.
        break;
      }
    }

    if (q != -1) {
      //If the name exists.
      print("You curently reserved seat ${q + 1}. Pick a new seat below");
      name[q] = null;
      checkSeats();
      int? ns = int.parse(stdin.readLineSync()!);
      name[ns - 1] = nem;
      print("Changing of seat reservation successful!");
    } else {
      //If it doesn't.
      print("No such name is found in the list. Ending process...");
    }

    checkSeats();
  }

  void viewSeats() {
    for (int B = 0; B < name.length; B++) {
      double Row = (B + 1) / 4; //Important for modulus
      int rowNum = Row.ceil(); //What row.
      int seatNum = (B % 4) + 1; //Which seat it is in the row.
      String? txt = ""; //Text to show if seat is occupied or not.

      if (name[B] == null) {
        //If seat is not occupied, display empty.
        txt = "EMPTY";
      } else {
        //If seat is occupied, display name of occupant.
        txt = name[B];
      }

      //Complete string to display for every entry in the array.
      print("Seat number ${B + 1} - Row $rowNum Seat $seatNum : ${txt}");
    }
  }

  void askNicely() {
    print(
        "[1] Book flight [2] Change Seats [3] Cancel Reservation [4] View Seats [5] Terminate Prompt");

    int? n = int.parse(stdin.readLineSync()!);

    switch (n) {
      case 1:
        {
          //Flight Booking operations in option 1
          bookFlight();
          askNicely();
        }
        break;

      case 2:
        {
          //Change Seating operations in option 2
          changeSeats();
          askNicely();
        }
        break;
      case 3:
        {
          //Reservation Deletion operations in option 3
          cancelReservation();
          askNicely();
        }
        break;
      case 4:
        {
          //Display seats and occupants in option 4
          viewSeats();
          askNicely();
        }
        break;
      case 5:
        {
          //Terminating the Program
          print("Thank you for choosing Mathilda Airlines!");
        }
        break;

      default:
        {
          //Nicely ask for proper input to proceed with booking operations
          print("Invalid Input!");
          askNicely();
        }
        break;
    }
  }

  //After all necessary functions have been declared, we start the prompt with the following statement.
  askNicely();
}
