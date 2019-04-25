function ownsValueProblem(A)
    clc;
    [L, X] = yakobyMethod(A, 0.000001);
    fprintf('Êîíîâàëîâ Ïåòğ Àëåêñååâè÷ 323\n\n5 âàğèàíò\n\n');
    fprintf('Ìàòğèöà:\n\n');
    disp(A);
    fprintf('Ñîáñòâåííûå ÷èñëà: ');
    ownv = zeros(1, size(L, 1));
    for k = 1: size(L, 1)
        fprintf('%.7f ', L(k, k));
        ownv(k) = L(k, k);
    end
    ownv = sortAbs(ownv);
    fprintf('\n\nÌàêñèìàëüíîå ïî ìîäóëş ñîáñâòåííîå ÷èñëî: %.7f', ownv(1));
    fprintf('\n\nÎòíîøåíèå ñîáñòâåííûõ ÷èñåë: %.7f', ownv(2) / ownv(1));
    fprintf('\n\nÑîáñòâåííûå âåêòîğû:\n');
    disp(X);
    
    Y0 = [-6; -3; 9]; %ñîâñåì õîğîøî [-7 -1 7]
    eps = 0.001;
    fprintf('----------ÑÒÅÏÅÍÍÎÉ ÌÅÒÎÄ----------\n\n');
    fprintf('Òî÷íîñòü: %.7f\n\n', eps);
    fprintf('Íà÷àëüíîå ïğèáëèæåíèå: \n');
    disp(Y0);
    fprintf('Âû÷èñëåíèÿ: \n');
    degreeMethod(A, Y0, ownv(1), eps);
    fprintf('\n');
    %printRes(A, val, vect, itCnt);
    
    eps = 0.000001;
    fprintf('----------ÌÅÒÎÄ ÑÊÀËßĞÍÛÕ ÏĞÎÈÇÂÅÄÅÍÈÉ----------\n\n');
    fprintf('Òî÷íîñòü: %.7f\n\n', eps);
    fprintf('Íà÷àëüíîå ïğèáëèæåíèå: \n');
    disp(Y0);
    fprintf('Âû÷èñëåíèÿ: \n');
    scalarMultMethod(A, Y0, ownv(1), eps);
    fprintf('\n');
    %printRes(A, val, vect, itCnt);
    
    Y0 = [-3; 10; 4];
    eps = 0.001;
    fprintf('----------ÏĞÎÒÈÂÎÏÎËÎÆÍÀß ÃĞÀÍÈÖÀ ÑÏÅÊÒĞÀ----------\n\n');
    M = A - ownv(1) * eye(size(A, 1));
    fprintf('Ìàòğèöà: \n');
    disp(M);
    [ownVectM, tmp] = eig(M);
    fprintf('Ñîáñâòåííûå ÷èñëà: ');
    ownValM = zeros(size(tmp, 1));
    for k = 1: size(tmp, 1)
        fprintf('%.7f ', tmp(k, k));
        ownValM(k) = tmp(k, k);
    end
    ownValM = sortAbs(ownValM);
    fprintf('\n\nÑîáñòâåííûå âåêòîğû: \n');
    disp(ownVectM);
    fprintf('Ìàêñèìàëüíîå ïî ìîäóëş ñîáñâòåííîå ÷èñëî: %.7f', ownValM(1));
    fprintf('\n\nÎòíîøåíèå ñîáñòâåííûõ ÷èñåë: %.7f', ownValM(2) / ownValM(1));
    fprintf('\n\nÒî÷íîñòü: %.7f', eps);
    fprintf('\n\nÍà÷àëüíîå ïğèáëèæåíèå: \n');
    disp(Y0);
    fprintf('Âû÷èñëåíèÿ: \n');
    scalarMultMethod(M, Y0, ownValM(1), eps);
    fprintf('\n');
    %printRes(A, rval + val, vect, itCnt);
    
    Y0 = [-7; -1; 7];
    eps = 0.000001;
    fprintf('----------ÌÅÒÎÄ ÂÈËÀÍÄÒÀ----------\n\n');
    fprintf('Òî÷íîñòü: %.7f\n\n', eps);
    fprintf('Íà÷àëüíîå ïğèáëèæåíèå ñîáñòâåííîãî âåêòîğà: \n');
    disp(Y0);
    v = -1.1;
    fprintf('Íà÷àëüíîå ïğèáëèæåíèå ñîáñòâåííîãî ÷èñëà: %.7f\n', v);
    fprintf('Ñîáñâòåííîå ÷èñëî ê êîòîğîìó ïğèáëèæàåìñÿ: %.7f\n', ownv(1));
    methodVilandta(A, v, Y0, ownv(1), eps); 
    %printRes(A, val, vect, itCnt);
end

%{
function printRes(A, val, vect, itCnt)
    fprintf('Ñîáñòâåííîå çíà÷åíèå: %.7f\n\n', val);
    fprintf('Ñîáñòâåííûé âåêòîğ:\n');
    disp(vect);
    fprintf('Íîğìà íåâÿçêè:\n');
    disp(norma(A*vect-val*vect));
    fprintf('Êîëè÷åñòâî èòåğàöèé: %d\n\n', itCnt);
    fprintf('Àïîñòåğèîğíàÿ îöåíêà ïîãğåøíîñòè: %d\n\n', norma(A * vect - val * vect) / norma(vect));
end
%}

function printIter(it, V, oldV, curV, nextV, curY, A)
    vE = (oldV * nextV - curV ^ 2) / (oldV + nextV - 2 * curV);
    nev = A * curY - curV * curY;
    fprintf('%3d %11.7f %11.7f %11.7f %11.7f %11.7f %11.7f %7.0e\n', it, curV, curV - oldV, curV - V, norma(nev), norma(nev) / norma(curY), vE, vE - V);
end

%{
function [val, vect, itCnt] = methodVilandtaOld(A, v, Y, eps)
    E = eye(size(A, 1));
    W = A - v * E;
    Y = Y / Y(getNormCoefId(Y));
    vect = W \ Y;
    val = vect' * Y / (Y' * Y);
    itCnt = 1;
    while abs(1 / val) > eps
        v = 1 / val + v;
        Y = vect;
        Y = Y / Y(getNormCoefId(Y));
        W = A - v * E;
        vect = W \ Y;   
        val = vect' * Y / (Y' * Y);
        itCnt = itCnt + 1;
    end
    val = v;
    vect = vect / norma(vect);
end
%}

function methodVilandta(A, v, Y, V, eps)
    E = eye(size(A, 1));
    oldV = v;
    W = A - oldV * E;
    fprintf('\n');
    disp(W);
    Y = Y / Y(getNormCoefId(Y));
    vect = W \ Y;
    val = vect' * Y / (Y' * Y);
    curV = 1 / val + oldV;
    
    Y = vect;
    Y = Y / Y(getNormCoefId(Y));
    W = A - curV * E;
    disp(W);
    vect = W \ Y;   
    val = vect' * Y / (Y' * Y);
    nextV = 1 / val + curV;   
    
    itCnt = 2;
    while abs(1 / val) > eps
        oldV = curV;
        curV = nextV;
        Y = vect;
        Y = Y / Y(getNormCoefId(Y));
        W = A - curV * E;
        vect = W \ Y;   
        val = vect' * Y / (Y' * Y);
        nextV = 1 / val + curV;
        printIter(itCnt, V, oldV, curV, nextV, Y, A);
        fprintf('\n');
        disp(W);
        itCnt = itCnt + 1;
    end
end

%{
function [val, vect, itCnt] = scalarMultMethodOld(A, Y, eps)
    Y = Y / Y(getNormCoefId(Y));
    nY = A * Y;
    oldV = nY' * Y / (Y' * Y);
    Y = nY / nY(getNormCoefId(nY));
    nY = A * Y;
    newV = nY' * Y / (Y' * Y);
    itCnt = 1;
    while abs(oldV - newV) > eps
        oldV = newV;
        Y = nY / nY(getNormCoefId(nY));
        nY = A * Y;
        newV = nY' * Y / (Y' * Y);
        itCnt = itCnt + 1;
    end
    val = newV;
    vect = nY / norma(nY);
end
%}

function scalarMultMethod(A, Y, V, eps)
    Y = Y / Y(getNormCoefId(Y));
    nY = A * Y;
    oldV = nY' * Y / (Y' * Y);
    
    Y = nY / nY(getNormCoefId(nY));
    nY = A * Y;
    curV = nY' * Y / (Y' * Y);
    
    Y = nY / nY(getNormCoefId(nY));
    nY = A * Y;
    nextV = nY' * Y / (Y' * Y);
    
    itCnt = 2;
    while abs(oldV - curV) > eps
        oldV = curV;
        curV = nextV;
        Y = nY / nY(getNormCoefId(nY));
        nY = A * Y;
        nextV = nY' * Y / (Y' * Y);
        printIter(itCnt, V, oldV, curV, nextV, Y, A);
        itCnt = itCnt + 1;
    end
end

function degreeMethod(A, Y, V, eps)
    p = getNormCoefId(Y);
    oldV = Y(p);
    Y = Y / oldV;
    nY = A * Y;
    curV = Y(p);
    Y = nY;
    Y = Y / curV;
    nY = A * Y;
    nextV = Y(p);
    itCnt = 2;
    while abs(oldV - curV) > eps
        Y = nY;
        p = getNormCoefId(Y);
        oldV = curV;
        curV = nextV;
        Y = Y / curV;
        nY = A * Y;
        nextV = Y(p);
        printIter(itCnt, V, oldV, curV, nextV, Y, A);
        itCnt = itCnt + 1;
    end
end

function [p] = getNormCoefId(Y)
    p = 1;
    for k = 2: numel(Y)
        if (abs(Y(k)) > abs(Y(p)))
            p = k;
        end
    end
end

function [res] = norma(Y)
    res = 0;
    for k = 1: numel(Y)
        res = res + Y(k) ^ 2;
    end
    
    res = sqrt(res);
end

function [res] = sortAbs(arr)
    res = arr;
    for j = 1: numel(arr) - 1
        for k = j + 1: numel(res)
            if abs(res(k)) > abs(res(j))
                tmp = res(j);
                res(j) = res(k);
                res(k) = tmp;
            end
        end
    end
end
