#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних перегородок)
#РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке
function main7!(r::Robot) #главная функция
    x, y = getStartPos(r)

    returnStartPos!(r, x, y)

    cnt = 1
    while isborder(r, Ost) == false
        markChessSide!(r, cnt)
        cnt += 1
        move!(r, Ost)
    end

    markChessSide!(r, cnt)

    while cnt > 1
        move!(r, West)
        cnt -= 1
    end

    cnt = 0

    while isborder(r, West) == false
        move!(r, West)
        markChessSide!(r, cnt)
        cnt += 1
    end

    while cnt > 0
        move!(r, Ost)
        cnt -= 1
    end
end

function getStartPos(r::Robot) #проверяет клетки по левой половине
    x, y = 0, 0

    while isborder(r, West) == false #двигает на запад
        x += 1
        move!(r, West)
    end

    while isborder(r, Sud) == false #двигает на юг 
        y += 1
        move!(r, Sud)
    end

    return x, y
end

function returnStartPos!(r::Robot, x, y) #возвращает робота в начаное место
    setLeftDown!(r)

    while x > 0
        move!(r, Ost)
        x -= 1
    end

    while y > 0
        move!(r, Nord)
        y -= 1
    end
end

function getXLen(r::Robot) #проверяет клетки по правому половине
    cnt = 0

    while isborder(r, Ost) == false #двигает робота на юг
        cnt += 1
        move!(r, Ost)
    end

    while isborder(r, West) == false #двигает на запад
        move!(r, West)
    end

    return cnt
end

function getYLen(r::Robot)
    cnt = 0

    while isborder(r, Nord) == false
        cnt += 1
        move!(r, Nord)
    end

    while isborder(r, Sud) == false
        move!(r, Sud)
    end

    return cnt
end

function setLeftDown!(r::Robot)
    while isborder(r, Sud) == false
        move!(r, Sud)
    end
    while isborder(r, West) == false
        move!(r, West)
    end
end

function markChessSide!(r::Robot, current)
    if current % 2 == 1
        putmarker!(r)
    end

    cnt = 0

    while isborder(r, Nord) == false
        cnt += 1
        move!(r, Nord)
        if cnt % 2 + current % 2 == 1
            putmarker!(r)
        end
    end
    
    while cnt > 0
        cnt -= 1
        move!(r, Sud)
    end

    while isborder(r, Sud) == false
        cnt += 1
        move!(r, Sud)
        if cnt % 2 + current % 2 == 1
            putmarker!(r)
        end
    end
    
    while cnt > 0
        cnt -= 1
        move!(r, Nord)
    end
end