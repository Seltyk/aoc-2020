import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;

class Node {
	private String value;
	private ArrayList<Node> connections;

	Node(String value) {
		this.value = value;
		connections = new ArrayList<>();
	}
}

class Graph {
	private ArrayList<Node> graph;

	public Graph() {
		graph = new ArrayList<>();
	}

	public boolean add(Node n) {
		return graph.add(n);
	}
}

public class Day7 {
	public static void main(String[] args) throws Exception {
		BufferedReader input;
		Graph bags = new Graph();

		input = new BufferedReader(new FileReader(new File("day7")));
		String line;
		do {
			line = input.readLine();

			if(line.matches("no other bags"))
				continue;

			String[] splitLine = line.split(" bags contain ");
			Node bag = new Node(splitLine[0]);

			for(String sub : splitLine[1].split(", "))
		} while(!line.equals(""));
	}
}
