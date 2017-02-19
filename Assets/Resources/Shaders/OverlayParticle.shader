Shader "Unlit/OverlayParticle"
{
    Properties
    {
        _MainTex("Color (RGB) Alpha (A)", 2D) = "white" {}
        _TintColor("Tint Color", Color) = (0.5, 0.5, 0.5, 0.5)
    }
    SubShader
    {
        Tags { "Queue" = "Overlay" "RenderType" = "Transparent" }
        LOD 100

        ZWrite Off
        ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vertex
            #pragma fragment fragment

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _TintColor;
            
            Varyings vertex (appdata v)
            {
                Varyings o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            fixed4 fragment (Varyings input) : SV_Target
            {
                float alpha = length(input.uv - .5);
                alpha = 1. - alpha * 2.;
                fixed3 color = tex2D(_MainTex, input.uv);
                return fixed4(color + _TintColor.rgb, alpha);
            }
            ENDCG
        }
    }
}
