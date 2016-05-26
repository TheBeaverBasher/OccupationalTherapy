function [camera_name, camera_id, resolution] = getCameraInfo(a)
camera_name = char(a.InstalledAdaptors(end));
camera_info = imaqhwinfo(camera_name);
camera_id = camera_info.DeviceInfo(1).DeviceID(end);
resolution = char(camera_info.DeviceInfo(1).SupportedFormats(end));