Config = {
    Locale = 'en' -- Language of the game (es - Spanish, en - English)
}

Locales = {
    ['es'] = { -- Spanish
        ['set_dimension_help'] = 'Poner la dimension a un jugador',
        ['set_dimension_player'] = 'Jugador',
        ['set_dimension_bucket'] = 'Dimension',
        ['set_dimension_notification'] = 'Has cambiado la dimension de %s a %s',
        ['set_dimension_error_notdimension'] = 'Debes ingresar una dimension valida',
        ['set_dimension_error_notplayerid'] = 'Debes ingresar un jugador valido',

        -- Getters

        ['get_dimension_help'] = 'Obtener la dimension de un jugador',
        ['get_dimension_player'] = 'Jugador',
        ['get_dimension_notification'] = 'La dimension de %s es %s',
        ['get_dimension_error_notplayerid'] = 'Debes ingresar un jugador valido',
    },

    ['en'] = { -- English
        ['set_dimension_help'] = 'Set the dimension of a player',
        ['set_dimension_player'] = 'Player',
        ['set_dimension_bucket'] = 'Dimension',
        ['set_dimension_notification'] = 'You have changed the dimension of %s to %s',
        ['set_dimension_error_notdimension'] = 'You must enter a valid dimension',
        ['set_dimension_error_notplayerid'] = 'You must enter a valid PlayerId',

        -- Getters

        ['get_dimension_help'] = 'Get the dimension of a player',
        ['get_dimension_player'] = 'Player',
        ['get_dimension_notification'] = 'The dimension of %s is %s',
        ['get_dimension_error_notplayerid'] = 'You must enter a valid PlayerId',
    }
}

function Locale(type, ...)
    if Locales[Config.Locale][type] then
        return Locales[Config.Locale][type]:format(...)
    else
        return 'Locale not found'
    end
end