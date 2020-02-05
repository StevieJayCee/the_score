import gql from "graphql-tag";
import React, { useMemo } from "react";
import { useQuery } from "@apollo/react-hooks"; //check diff to react-apollo
import Table from "./Table";

function Players(props) {
  const GET_RUSHINGS = gql`
    query Rushing($filter: String, $sort: String) {
      rushing(filter: $filter, sort: $sort) {
        attemptGameAverage
        attempts
        firstDown
        firstDownPercent
        fortyPlusYards
        fumbles
        longest
        player
        position
        team
        totalYards
        touchdowns
        twentyPlusYards
        yardsAttemptAverage
        yardsGame
      }
    }
  `;

  const columns = useMemo(
    () => [
      {
        Header: "Rushings",
        columns: [
          {
            Header: "Player",
            accessor: "player"
          },
          {
            Header: "Team",
            accessor: "team"
          },
          {
            Header: "Position",
            accessor: "position"
          },
          {
            Header: "Rushing attempts per game average",
            accessor: "attemptGameAverage"
          },
          {
            Header: "Rushing attempts",
            accessor: "attempts"
          },
          {
            Header: "Total rushing yards",
            accessor: "totalYards"
          },
          {
            Header: "Rushing average yards per attempt",
            accessor: "yardsAttemptAverage"
          },
          {
            Header: "Rushing Yards Per Game",
            accessor: "yardsGame"
          },
          {
            Header: "Total Rushing Touchdowns",
            accessor: "touchdowns"
          },
          {
            Header: "Longest Rush",
            accessor: "longest"
          },
          {
            Header: "Rushing First Downs",
            accessor: "firstDown"
          },
          {
            Header: "Rushing First Down Percentage",
            accessor: "firstDownPercent"
          },
          {
            Header: "Rushing 20+ Yards Each",
            accessor: "twentyPlusYards"
          },
          {
            Header: "Rushing 40+ Yards Each",
            accessor: "fortyPlusYards"
          },
          {
            Header: "Rushing Fumbles",
            accessor: "fumbles"
          }
        ]
      }
    ],
    []
  );

  // useLazyQuery will allow for calls when needed
  const { loading, error, data } = useQuery(GET_RUSHINGS, {
    variables: props.variables
  });

  if (loading) return <div>"loading...";</div>;
  if (error) return <div> "Error! ${error.message}"</div>;
  return (
    <div>
      {data.rushing.length === 0 ? (
        <h1>No rushing Found</h1>
      ) : (
        <Table columns={columns} data={data.rushing} />
      )}
    </div>
  );
}

export default Players;
