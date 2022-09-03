for _ , v in pairs(script.Parent.services:GetChildren()) do
    if v:IsA("ModuleScript") then
        require(v)
    end
end