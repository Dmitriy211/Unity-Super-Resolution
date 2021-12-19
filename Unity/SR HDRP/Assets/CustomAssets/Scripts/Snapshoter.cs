using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Snapshoter : MonoBehaviour
{
    private Camera _camera;
    private int _height;
    private int _width;

    private void Awake()
    {
        _camera = GetComponent<Camera>();
        _height = _camera.targetTexture.height;
        _width = _camera.targetTexture.width;
    }

    private void LateUpdate()
    {
        if (Input.GetKeyDown(KeyCode.F2))
        {
            TakeSnapshot();
        }
    }

    private void TakeSnapshot()
    {
        Texture2D image = new Texture2D(_width, _height, TextureFormat.RGBA32, false);
        _camera.Render();
        RenderTexture.active = _camera.targetTexture;
        image.ReadPixels(new Rect(0, 0, _width, _height), 0, 0);
        byte[] imageBytes = image.EncodeToPNG();
        string path = $"{Application.dataPath}/Snapshots/{DateTime.Now:yy-mm-dd}.png";
        System.IO.File.WriteAllBytes(path, imageBytes);
        Debug.Log($"Snapshot saved at {path}");
    }
}
