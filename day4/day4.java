import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class day4 {
    public static void main(String[] args) {
        ArrayList<String> numbersToCall = new ArrayList<>();
        ArrayList<Player> players = new ArrayList<>();
        ArrayList<String> lines = new ArrayList<>();

        try {
            File f = new File("/win/Users/mrkyl/code_projects/advent_of_code/day4/input.txt");
            Scanner sc = new Scanner(f);

            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                lines.add(line);
            }
            sc.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // get numbers to call
        var vals = Arrays.stream(lines.get(0).split(","))   // new java 🤔
            .collect(Collectors.toList());
        for (var val : vals) {
            numbersToCall.add(val);
        }
        
        
        // get bingo stamp cards
        // get rid of numbers to call and blank line
        lines.remove(0);
        lines.remove(0);

        int cardNumber = 1;
        
        for (int line = 0; line < lines.size(); line++) {
            if (lines.get(line).equals("")) {
                // System.out.println("detected bingo card");
                cardNumber++;
                String[][] values = new String[5][5];
                int localCardRow = 0;
                for (int cardRow = line + 1; cardRow <= line + 5; cardRow++) {
                    String cardRowString = lines.get(cardRow);
                    // System.out.println("\nCard row " + cardRow + ": " + lines.get(cardRow));
                    
                    Pattern pattern = Pattern.compile("(^..) (..) (..) (..) (..$)");
                    Matcher matcher = pattern.matcher(cardRowString);
                    if (matcher.find()) {
                        String[] rowValues = new String[5];
                        for (int groupNumber = 1; groupNumber <= matcher.groupCount(); groupNumber++) {
                            rowValues[groupNumber - 1] = matcher.group(groupNumber);
                        }
                        values[localCardRow] = rowValues;
                        localCardRow++;
                    }
                }
                Player player = new Player(cardNumber, values);
                players.add(player);
                System.out.println("\n" + player + "\n");
            }
        }
        
        
        Game game = new Game(numbersToCall, new ArrayList<Player>(players));
        game.play();
    }
}

class Game {
    public ArrayList<String> numbersToCall;
    public ArrayList<Player> players;
    
    public Game(ArrayList<String> numbersToCall, ArrayList<Player> players) {
        this.numbersToCall = numbersToCall;
        this.players = players;
    }

    public String drawNumber() {
        String calledNumber = numbersToCall.get(0);
        numbersToCall.remove(0);
        
        return calledNumber;
    }

    public void updatePlayers(String number) {
        for (Player player : players) {
            player.update(number);
        }
    }

    public Map<Player, Integer> checkForWinConditions() {
        for (Player player : players) {
            Map<Player, Integer> map = player.checkForWinCondition();
            if (map != null) {
                return map;
            }
        }
        return null;
    }

    public void play() {
        for (int i = numbersToCall.size() - 1; i >= 0; i--) {
            String calledNumber = drawNumber();
            System.out.println("The called number is " + calledNumber + "!");
            
            updatePlayers(calledNumber);
            
            Map<Player, Integer> map = checkForWinConditions();

            if (map != null) {
                System.out.println("\n" + map.keySet().toArray()[0]);
                System.out.println("Player " + ((Player) map.keySet().toArray()[0]).getId() + " wins!");
                System.out.println("The sum of the unmarked numbers was: " + map.get(map.keySet().toArray()[0]));
                System.out.println("The sum of the unmarked numbers multiplied by the winning number was: " + ((int) (map.get(map.keySet().toArray()[0])) * Integer.parseInt(calledNumber)));

                return;
            }
        }
    }
}

class Player {
    private int id;
    private String[][] stampSheet;
    
    public Player(int id, String[][] values) {
        this.id = id;
        this.stampSheet = values;
    }
    
    public int getId() {
        return this.id;
    }

    @Override
    public String toString() {
        String s = "Player " + id + "\n";
        
        for (int row = 0; row < 5; row++) {
            for (int column = 0; column < 5; column++) {
                boolean cross = false;
                if (stampSheet[row][column].equals("XX")) cross = true;
                if (cross) s += "\u001B[31m";
                s += stampSheet[row][column];
                if (cross) s += "\u001B[0m";
                if (column < 4) s += " ";
            }
            s += "\n";
        }
        
        return s;
    }

    public void update(String number) {
        for (int row = 0; row < 5; row++) {
            for (int column = 0; column < 5; column++) {
                if (stampSheet[row][column].trim().equals(number)) {
                    stampSheet[row][column] = "XX";
                }
            }
        }
    }

    public Map<Player, Integer> checkForWinCondition() {
        Map<Player, Integer> map = new HashMap<Player, Integer>();
        
        boolean win = false;
        int sum = 0;
        int streak = 0;

        // check for horizontal win
        for (int row = 0; row < 5; row++) {
            for (int column = 0; column < 5; column++) {
                if (stampSheet[row][column].equals("XX")) {
                    streak++;
                } else {
                    sum += Integer.parseInt(stampSheet[row][column].trim());
                }
                if (streak == 5) win = true;
            }
            streak = 0;
        }
        
        if (win) {
            System.out.println("Unmarked numbers sum: " + sum);
            map.put(this, sum);
            return map;
        }

        // check for vertical win
        for (int column = 0; column < 5; column++) {
            for (int row = 0; row < 5; row++) {
                if (stampSheet[row][column].equals("XX")) {
                    streak++;
                } else {
                    sum += Integer.parseInt(stampSheet[row][column].trim());
                }
                if (streak == 5) win = true;
            }
            streak = 0;
        }
        if (win) {
            System.out.println("Unmarked numbers sum: " + sum);
            map.put(this, sum);
            return map;
        }

        return null;
    }
}
