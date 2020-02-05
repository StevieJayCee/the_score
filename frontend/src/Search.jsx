import React, { useState } from "react";
const Search = props => {
  const [player, setPlayer] = useState("");
  const [touchdowns, setTouchdowns] = useState("");
  const [longest, setLongest] = useState("");
  const [totalYards, setTotalYards] = useState("");

  function handleSubmit() {
    let variables = {
      filter: { player },
      sort: {
        touchdowns,
        longest,
        totalYards
      }
    };

    props.onFormSubmit(variables);
  }

  return (
    <div>
      <form
        onSubmit={e => {
          e.preventDefault();
          handleSubmit();
        }}
      >
        <label htmlFor="player">
          <span>Filter by player name:</span>
          <input
            id="player"
            value={player}
            onChange={event => setPlayer(event.target.value)}
            placeholder="player name"
          />
        </label>

        <label htmlFor="touchdowns">
          <span>Sort by touchdowns</span>
          <select
            id="touchdowns"
            defaultValue=""
            onChange={event => setTouchdowns(event.target.value)}
          >
            <option value="desc">Descending</option>
            <option value="asc">Ascending</option>
            <option value="">none</option>
          </select>
        </label>
        <label htmlFor="longest-rush">
          <span>Sort by Longest Rush</span>
          <select
            id="longest-rush"
            defaultValue=""
            onChange={event => setLongest(event.target.value)}
          >
            <option value="desc">Descending</option>
            <option value="asc">Ascending</option>
            <option value="">none</option>
          </select>
        </label>
        <label htmlFor="longest-rush">
          <span>Sort by Total Yards</span>
          <select
            id="total-yards"
            defaultValue=""
            onChange={event => setTotalYards(event.target.value)}
          >
            <option value="desc">Descending</option>
            <option value="asc">Ascending</option>
            <option value="">none</option>
          </select>
        </label>
        <button>Submit</button>
      </form>
    </div>
  );
};
export default Search;
