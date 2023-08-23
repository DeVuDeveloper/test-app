import { screen } from '@testing-library/dom';
import { getHTML, setHTML, startStimulus } from './_stimulus_helper';
import CookiesController from '../../app/javascript/controllers/cookies_controller';

beforeEach(() => startStimulus('cookies', CookiesController));

test('fetches oven status and updates UI', async () => {
  await setHTML(`
    <div data-controller="oven-status" data-oven-id="123">
      <div data-oven-status-target="timer"></div>
      <button data-oven-status-target="button">
        Remaining time: 0 seconds
      </button>
      <div data-oven-status-target="ready"></div>
      <div data-oven-status-target="loader"></div>
    </div>
  `);

  global.fetch = jest.fn(() =>
    Promise.resolve({
      json: () => Promise.resolve({ ready: true, time_left: 0 }),
    })
  );

  await screen.findByRole('button', { name: 'Remaining time: 0 seconds' });

  expect(getHTML()).toMatchSnapshot();
});



