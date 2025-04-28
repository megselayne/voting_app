import React from 'react';

const Vote = ({ candidates, election, flashMessage }) => {
  const candidatesCount = candidates.length;

  return (
    <main className='vote-page'>
      {flashMessage && <div className='alert alert-danger'>{flashMessage}</div>}
      <h1>Cast your vote today!</h1>

      {/* Voting form if candidates exist */}
      {candidatesCount > 0 && (
        <form action={`/elections/${election.slug}/votes`} method='post' aria-labelledby='vote-form-title'>
          <input type='hidden' name='authenticity_token' value={document.querySelector('meta[name="csrf-token"]').content} />
          <fieldset>
            {candidates.map((candidate) => (
              <div key={candidate.id}>
                <label>
                  <input className='vote-page__radio-input' type='radio' name='candidate_id' value={candidate.id} required /> {candidate.name}
                </label>
              </div>
            ))}
          </fieldset>
          <button type='submit' className='btn-primary'>Vote</button>
        </form>
      )}

      {/* Add a new candidate form */}
      {/* Max 10 candidates*/}
      {candidatesCount < 10 && (
        <section aria-labelledby='add-candidate-title'>
        <p id='add-candidate-title'>{candidatesCount > 0 ? 'Or, add a new candidate:' : 'Add a new candidate:'}</p>
        <form action={`/elections/${election.slug}/votes`} method='post' aria-labelledby='add-candidate-title'>
          <input type='hidden' name='authenticity_token' value={document.querySelector('meta[name="csrf-token"]').content} />
          <input className='vote-page__input' type='text' id='candidate_name' name='candidate[name]' placeholder='Enter name...' required />
          <button type='submit' className='btn-primary'>Vote</button>
        </form>
      </section>
      )}
    </main>
  );
};

export default Vote;