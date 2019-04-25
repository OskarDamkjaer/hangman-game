import React from "react";
import {
    Socket
} from "phoenix";

const displayState = {
    won: "You won!",
    init: "just starting up",
    lost: "You lost :(",
    good_guess: "Good guess.",
    bad_guess: "Bad guess",
    already_used: "You already used that"
};
const all_letters = "abcdefghijklmnopqrstuvwxyz".split("");

class Hangman extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            game_state: "init",
            letters: [],
            turns_left: 7,
            used: []
        };
        this.socket = new Socket("/socket", {});
        this.socket.connect();
    }

    setup_channel() {
        this.channel = this.socket.channel("hangman:game", {});
        this.channel
            .join()
            .receive("ok", resp => this.channel.push("tally", {}))
            .receive("error", resp => alert(resp));
    }

    componentDidMount() {
        this.setup_channel();
        this.updateOnTally();
    }

    updateOnTally() {
        this.channel.on("tally", tally =>
            this.setState({
                ...tally
            })
        );
    }

    determineStyle(letter, guessed, correct) {
        if (correct.includes(letter)) {
            return "green"
        }
        if (guessed.includes(letter)) {
            return "red"
        }

        return "blue"

    }

    render() {
        const {
            game_state,
            letters,
            turns_left,
            used
        } = this.state;

        return (
            <div>
        <div>{`word so far ${letters.join(" ")}`}</div>
        <div>{`used so far ${used.join(", ")}`}</div>
        <div>{`turns left ${turns_left}`}</div>
        <div>{`game status ${displayState[game_state]}`}</div>
        {all_letters.map(guess => (
          <button
            key={guess}
              style={{backgroundColor: this.determineStyle(guess,used,letters)}}
            onClick={() => this.channel.push("make_move", { guess })}
          >
            {guess}
          </button>
        ))}
      </div>
        );
    }
}

export default Hangman;
