function costs = cmaesParallelSplit(gainsPop)
    global rtp InitialGuess
    %allocate costs vector and paramsets the generation
    popSize = size(gainsPop,2);
    costs = nan(1,popSize);
    paramSets = cell(popSize,1);

    %create param sets
    for i = 1:popSize
        Gains = InitialGuess.*exp(gainsPop(:,i));

        paramSets{i} = Simulink.BlockDiagram.modifyTunableParameters(rtp, ...
            'LGainGAS',           Gains( 1), ...
            'LGainGLU',           Gains( 2), ...
            'LGainHAM',           Gains( 3), ...
            'LGainKneeOverExt',   Gains( 4), ...
            'LGainSOL',           Gains( 5), ...
            'LGainSOLTA',         Gains( 6), ...
            'LGainTA',            Gains( 7), ...
            'LGainVAS',           Gains( 8), ...
            'LKglu',              Gains( 9), ...
            'LPosGainGG',         Gains(10), ...
            'LSpeedGainGG',       Gains(11), ...
            'LhipDGain',          Gains(12), ...
            'LhipPGain',          Gains(13), ...
            'LkneeExtendGain',    Gains(14), ...
            'LkneeFlexGain',      Gains(15), ...
            'LkneeHoldGain1',     Gains(16), ...
            'LkneeHoldGain2',     Gains(17), ...
            'LkneeStopGain',      Gains(18), ...
            'LlegAngleFilter',    Gains(19), ...
            'LlegLengthClr',      Gains(20), ...
            'RGainGAS',           Gains(21), ...
            'RGainGLU',           Gains(22), ...
            'RGainHAM',           Gains(23), ...
            'RGainHAMCut',        Gains(24), ...
            'RGainKneeOverExt',   Gains(25), ...
            'RGainSOL',           Gains(26), ...
            'RGainSOLTA',         Gains(27), ...
            'RGainTA',            Gains(28), ...
            'RGainVAS',           Gains(29), ...
            'RKglu',              Gains(30), ...
            'RPosGainGG',         Gains(31), ...
            'RSpeedGainGG',       Gains(32), ...
            'RhipDGain',          Gains(33), ...
            'RhipPGain',          Gains(34), ...
            'RkneeExtendGain',    Gains(35), ...
            'RkneeFlexGain',      Gains(36), ...
            'RkneeHoldGain1',     Gains(37), ...
            'RkneeHoldGain2',     Gains(38), ...
            'RkneeStopGain',      Gains(39), ...
            'RlegAngleFilter',    Gains(40), ...
            'RlegLengthClr',      Gains(41), ...
            'simbiconGainD',      Gains(42), ...
            'simbiconGainV',      Gains(43), ...
            'simbiconLegAngle0',  Gains(44), ...
            'anklePgain',         Gains(45), ...
            'ankleDgain',         Gains(46), ...
            'ankleFilterPID',     Gains(47), ...
            'ankleFilterSEA',     Gains(48), ...
            'kneePgain',          Gains(49), ...
            'kneeDgain',          Gains(50), ...
            'kneeFilterPID',      Gains(51), ...
            'kneeFilterSEA',      Gains(52), ...
            'legAngleTgt',        Gains(53));
    end

    %simulate each sample and store cost
    parfor i = 1:popSize
        costs(i) = evaluateCostParallel(paramSets{i})
    end
