import {Container} from 'typescript-ioc';

import {HelloWorldService} from '../../src/services';
import {ApiServer} from '../../src/server';
import {buildApiServer} from '../helper';

describe('Hello World service', () =>{

  let app: ApiServer;
  let service: HelloWorldService;
  beforeAll(() => {
    app = buildApiServer();

    service = Container.get(HelloWorldService);
  });

  test('canary test verifies test infrastructure', () => {
    expect(service).not.toBeUndefined();
  });

  describe('Given greeting()', () => {
    context('when "Juan" provided', () => {
      const name = 'Juan';
      test('then return "Witaj, Juan!"', async () => {
        expect(await service.greeting(name)).toEqual(`Witaj, ${name}!`);
      });
    });

    context('when no name provided', () => {
      test('then return "Witaj, World!"', async () => {
        expect(await service.greeting()).toEqual('Witaj, World!');
      });
    })
  });
});
