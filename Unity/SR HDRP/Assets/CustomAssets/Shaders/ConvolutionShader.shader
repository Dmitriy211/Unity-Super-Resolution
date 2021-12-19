Shader "Custom/ConvolutionShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                float2 delta = float2(0.002, 0.002);
				
				float4 hr = float4(0, 0, 0, 0);
				float4 vt = float4(0, 0, 0, 0);
				hr += tex2D(_MainTex, (i.uv + float2(-1.0, -1.0) * delta)) *  1.0;
                hr += tex2D(_MainTex, (i.uv + float2( 0.0, -1.0) * delta)) *  0.0;
                hr += tex2D(_MainTex, (i.uv + float2( 1.0, -1.0) * delta)) * -1.0;
                hr += tex2D(_MainTex, (i.uv + float2(-1.0,  0.0) * delta)) *  2.0;
				hr += tex2D(_MainTex, (i.uv + float2( 0.0,  0.0) * delta)) *  0.0;
				hr += tex2D(_MainTex, (i.uv + float2( 1.0,  0.0) * delta)) * -2.0;
				hr += tex2D(_MainTex, (i.uv + float2(-1.0,  1.0) * delta)) *  1.0;
				hr += tex2D(_MainTex, (i.uv + float2( 0.0,  1.0) * delta)) *  0.0;
				hr += tex2D(_MainTex, (i.uv + float2( 1.0,  1.0) * delta)) * -1.0;
				vt += tex2D(_MainTex, (i.uv + float2(-1.0, -1.0) * delta)) *  1.0;
				vt += tex2D(_MainTex, (i.uv + float2( 0.0, -1.0) * delta)) *  2.0;
				vt += tex2D(_MainTex, (i.uv + float2( 1.0, -1.0) * delta)) *  1.0;
				vt += tex2D(_MainTex, (i.uv + float2(-1.0,  0.0) * delta)) *  0.0;
				vt += tex2D(_MainTex, (i.uv + float2( 0.0,  0.0) * delta)) *  0.0;
				vt += tex2D(_MainTex, (i.uv + float2( 1.0,  0.0) * delta)) *  0.0;
				vt += tex2D(_MainTex, (i.uv + float2(-1.0,  1.0) * delta)) * -1.0;
				vt += tex2D(_MainTex, (i.uv + float2( 0.0,  1.0) * delta)) * -2.0;
				vt += tex2D(_MainTex, (i.uv + float2( 1.0,  1.0) * delta)) * -1.0;
				hr = sqrt((hr.r * hr.r) + (hr.g * hr.g) +  (hr.b * hr.b));
				vt = sqrt((vt.r * vt.r) + (vt.g * vt.g) +  (vt.b * vt.b));		
				return sqrt(hr * hr + vt * vt);
            }
            ENDCG
        }
    }
}
