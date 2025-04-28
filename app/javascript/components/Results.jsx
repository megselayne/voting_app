import React from 'react';

const ResultsTable = ({ results }) => {
  return (
    <div className="results-container">
      <table className="results-table" aria-label="Election Results">
        <h1 className="results-table__caption">Results</h1>
        <thead>
          <tr>
            <th scope="col" className="results-table__header">Candidate</th>
            <th scope="col" className="results-table__header">Votes</th>
          </tr>
        </thead>
        <tbody>
          {Object.entries(results).map(([candidate, votes]) => (
            <tr key={candidate} className="results-table__row">
              <td className="results-table__cell">{candidate}</td>
              <td className="results-table__cell">{votes}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default ResultsTable;