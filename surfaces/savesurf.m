function savesurf(h,flag,fname)

if nargin==3
    [fdir,fname,~] = fileparts(fname);
else
    fname = '';
end

% Save figure as JPEG:
if any(flag==1)
    if isempty(fname)
        [fname,fdir] = uiputfile('*.jpg','Save figure as:');
        if ~ischar(fname)
            fname = '';
        end
    else
        fname = [fname,'.jpg'];
    end
    if ~isempty(fname)
        saveas(h.hfig,fullfile(fdir,fname));
    end
end

% Save object rotation movie:
if any(flag==2) && all(isfield(h,{'axes1','axes2','lightAngle1','lightAngle2','hfig'}))
    if isempty(fname)
        [fname,fdir] = uiputfile('*.mp4','Save video as:');
        if ~ischar(fname)
            fname = '';
        end
    else
        fname = [fname,'.mp4'];
    end
    if ~isempty(fname)
        a = 0:4:359;
        v = VideoWriter(fullfile(fdir,fname),'MPEG-4');
        open(v);
        for i = 1:length(a)
            view(h.axes1,90+a(i),0);
            lightangle(h.lightAngle1,60+a(i),-30);
            view(h.axes2,270+a(i),0);
            lightangle(h.lightAngle2,240+a(i),-30);
            writeVideo(v,getframe(h.hfig));
        end
        close(v);
    end
end

% Save patch object as WRL:
if any(flag==3)
    if isempty(fname)
        [fname,fdir] = uiputfile('*.wrl','Save surface as:');
        if ~ischar(fname)
            fname = '';
        end
    else
        fname = [fname,'.wrl'];
    end
    if ~isempty(fname)
        vrml(h.ha1,fullfile(fdir,fname),'noedgelines');
    end
end


