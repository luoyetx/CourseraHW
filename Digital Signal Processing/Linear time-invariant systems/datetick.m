function [] = datetick(axis_handle, lim, dates_ts)
    
    set(axis_handle, 'xlim', lim);
    
    xtick = get(axis_handle, 'xtick');
    label_list = dates_ts(xtick);
    xticklabel = num2str(label_list(1), '%d')
    for i = 2:length(label_list)
        xticklabel = [xticklabel '|' num2str(label_list(i), '%d')];
    end
    set(axis_handle, 'xticklabel', xticklabel);
    
end