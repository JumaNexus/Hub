WindUI.Services.junkiedev = { Name = "Junkie Dev", Icon = "key", -- Icon dari Lucide (bisa diganti)

-- Argumen yang wajib diisi di tabel API nanti
Args = { "ServiceName", "Identifier", "Provider" }, 

New = function(ServiceName, Identifier, Provider)
    -- Memuat SDK Junkie Dev secara dinamis
    local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
    
    -- Konfigurasi SDK berdasarkan argumen yang diterima
    Junkie.service = ServiceName
    Junkie.identifier = Identifier
    Junkie.provider = Provider or "Mixed" -- Default ke Mixed jika kosong

    -- Fungsi Validasi (WindUI Expectation: return boolean, string_message)
    local function validateKey(key)
        if not key or key == "" then 
            return false, "Key cannot be empty!" 
        end

        -- Memanggil fungsi check_key dari SDK Junkie
        local result = Junkie.check_key(key)

        if result.valid then
            return true, "Key Validated Successfully!"
        else
            -- Mengambil pesan error dari API Junkie
            local msg = result.message or result.error or "Unknown Error"
            
            -- Penanganan khusus (Opsional)
            if msg == "HWID_BANNED" then
                return false, "HWID is Banned!"
            elseif msg == "KEY_EXPIRED" then
                return false, "Key Expired!"
            end
            
            return false, msg
        end
    end

    -- Fungsi Copy Link (WindUI Expectation: setclipboard & return string)
    local function copyLink()
        -- Memanggil fungsi get_key_link dari SDK Junkie
        local link, err = Junkie.get_key_link()
        
        if link then
            setclipboard(link)
            return "Copied to clipboard: " .. link
        else
            return "Error: " .. tostring(err)
        end
    end

    return {
        Verify = validateKey,
        Copy = copyLink
    }
end
}
