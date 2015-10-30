function [png] = generator_pdf()

png.PN_name = 'Scheduler';

png.set_of_Ps = {'pJobbUnits', 'pTask', 'pExecute', 'pJobbDone', 'pTrigger', 'pReady'};
png.set_of_Ts = {'tColorizer', 'tInit', 'tProcessor', 'tRemove'};
png.set_of_As = {'pJobbUnits', 'tColorizer', 1, 'tColorizer', 'pTask', 1,...
                'pTask', 'tInit', 1, 'tInit', 'pExecute', 1, 'pExecute', 'tProcessor',...
                1, 'tProcessor', 'pJobbDone', 1, 'tProcessor', 'pTrigger', 1,...
                'pTrigger', 'tRemove', 1, 'tRemove', 'pReady', 1, 'pReady', 'tInit', 1};