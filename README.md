# theScore "the Rush" Interview Question
At theScore, we are always looking for intelligent, resourceful, full-stack developers to join our growing team. To help us evaluate new talent, we have created this take-home interview question. This question should take you no more than a few hours.

**All candidates must complete this before the possibility of an in-person interview. During the in-person interview, your submitted project will be used as the base for further extensions.**

### Why a take-home interview?
In-person coding interviews can be stressful and can hide some people's full potential. A take-home gives you a chance work in a less stressful environment and showcase your talent.

We want you to be at your best and most comfortable.

### A bit about our tech stack
As outlined in our job description, you will come across technologies which include a server-side web framework (either Ruby on Rails or a modern Javascript framework) and a front-end Javascript framework (like ReactJS)

### Understanding the problem
In this repo is the file [`rushing.json`](/rushing.json). It contains data about NFL players' rushing statistics. Each entry contains the following information
* `Player` (Player's name)
* `Team` (Player's team abreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yrds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

##### Requirements
1. Create a web app. This must be able to do the following steps
    1. Create a webpage which displays a table with the contents of `rushing.json`
    2. The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
    3. The user should be able to filter by the player's name
    4. The user should be able to download the sorted/filtered data as a CSV

2. Update the section `Installation and running this solution` in the README file explaining how to run your code

### Submitting a solution
1. Download this repo
2. Complete the problem outlined in the `Requirements` section
3. In your personal public GitHub repo, create a new public repo with this implementation
4. Provide this link to your contact at theScore

We will evaluate you on your ability to solve the problem defined in the requirements section as well as your choice of frameworks, and general coding style.

### Help
If you have any questions regarding requirements, do not hesitate to email your contact at theScore for clarification.

### Installation and running this solution

#### Prerequisites

NPM(v13.x)
https://www.npmjs.com/get-npm 
or 
https://github.com/nvm-sh/nvm#installing-and-updating

Elixir(1.9.4)
Erlang(OTP 22)
https://elixir-lang.org/install.html

Postgres
Latest or latest stable
Setup `postgres` user with password `postgres`
Or trust all local connections


1. Download this repo
2. Navigate to api directory
3. `mix deps.get && mix ecto.reset && mix phx.server`
4. Navigate to frontend directory
5. `npm install && npm start`

#### Usage

##### User interface
Open up http://localhost:3000/ in a browser for the frontend app


##### API interface:
Open up http://localhost:4000/graphiql in a browser for the API.


example usage:

Get select fields for all rushing records:
```
{
  rushing{
    player
    totalYards
    touchdowns
    longest
  }
}
```

Combining sort and filter
```
{
  rushing(filter: {player: "and"}, sort: {touchdowns: "desc", totalYards: "desc"}){
    player
    totalYards
    touchdowns
    longest
  }
}
```
