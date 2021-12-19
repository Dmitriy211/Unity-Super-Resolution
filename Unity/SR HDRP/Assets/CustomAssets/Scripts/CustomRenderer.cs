using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

public class CustomRenderer : MonoBehaviour
{
    [SerializeField] private RenderTexture _input;
    [SerializeField] private Material _output;

    private void Update()
    {
        Texture2D texture = new Texture2D(_input.width, _input.height, TextureFormat.RGB24, false);
        RenderTexture.active = _input;
        texture.ReadPixels(new Rect(0, 0, _input.width, _input.height), 0, 0);
        Color[] pixels = texture.GetPixels();
        
        // pixels logix
        // for (int i = 0; i < pixels.Length; i++)
        // {
        //     pixels[i].g *= 2;
        // }

        texture.SetPixels(pixels);
        texture.Apply();
        _output.mainTexture = texture;
    }
}
