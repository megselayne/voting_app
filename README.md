## Installation and Use

Your development environment should have:

* Ruby v3.1.2
* [Bundler](https://bundler.io/)
* Node v20.18.2
* Yarn v1.22.19
* git
* [SQLite3](https://www.sqlite.org/)

Initialize git, install the application, and initialize the database:

```sh
# First, download the zip file, unzip the directory,
# and navigate into the project directory. Then:
git init
git add .
git commit -m "Initial files provided"
bundle install
bundle exec rake db:migrate
# Seed the db with starter election
bundle exec rails db:seed

# Install JS packages, including React
yarn install
```

## Running the app

```sh
bundle exec rails server
```

To logout your user in development:
```
GET /logout
```
Visit [http://localhost:3000](http://localhost:3000) in your browser

For asset live reloading, run:
```sh
./bin/shakapacker-dev-server
```

If the assets ever get out of sync, delete `/public/packs` and restart your
Rails server (and your shakapacker-dev-server if it was running).

## Approach and Technical Notes
- I first considered what models and routes I would need to support the requirements and wireframes.
  - The necessary models were:
    - User
    - Candidate
    - Vote
  - I chose to add Election for scale. Without an election model, the app would be hamstrung after a single use case. You’d either have to download and dump the database, or you’d end up overhauling the architecture.
- I quickly decided that I wanted to build the results page, because it seemed fun, and I knew the query would be simple enough. 
- I did note, though, that the table for this query would be one that could get quite heavy with scale. As such, indexing would be important and, if instantaneous results were not necessary, caching could be considered as well.
- I leveraged a find or create by in the sign in flow to accommodate there not being separate designs for signing up.
- I was very curious about fuzzy matching for candidate name de-duping. I’d never done it personally and vetted FuzzyMatch before setting on AMatch, for its superior control. FuzzyMatch though Shoshana Bean and Sutton Foster were a duplicate match. That was not acceptable. AMatch allowd me the granularity to set how many in place characters could differ between the strings I compared, which gave me a result I was happy with for this time frame. 
- I added a `GET /logout` endpoint for development only to allow for testing, in the absence of a formal logout feature in designs. In real world, I would’ve asked the PM about adding this functionality before release.
- I did my best to keep accessibility in mind with my react components by using semantic HTML, aria labels, and relative units in my styling.

## Scope
- Fuzzy matching
- Semantic HTML, aria labels, relative units
- Results page

## Next Steps
- With a short amount of time to build this app, there are naturally many places for improvement. Here are a few starting points I considered:

### Test Coverage
- [ ] Ensure rescues are working as expected
  - [ ] exceeding 10 candidates raises record invalid
    - [ ] flash message created
  - [ ] a user voting more than 1x per election raises record invalid
    - [ ] flash message created
- [ ] Fuzzy matching
  - [ ] candidate_names = [‘Audra McDonald’, ‘Shoshana Bean’, ‘Sutton Foster’]
  - [ ] A submission of `’Audra MacDonald’` should match an existing candidate
  - [ ] Vote should be cast for existing candidate `‘Audra McDonald’`

### WCAG
- [ ] Keyboard accessibility
- [ ] Focus order

### UX Improvements
- [ ] The user flow is largely dictated by redirects right now. Some of this is okay, but it would be nice to have some traditional navigation and possibly some secondary state copy for when a user has already voted etc.
