sampler g_SamplerTexture : register(s0);

float4 main() : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_SamplerTexture, 0.3);
	r1 = tex2D(g_SamplerTexture, float4(0.35, 0.3, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.4, 0.3, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.45, 0.3, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.5, 0.3, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.55, 0.3, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.6, 0.3, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.65, 0.3, 0.5, 0.35));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.3, 0.35, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, 0.35);
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.4, 0.35, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.45, 0.35, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.5, 0.35, 0.5, 0.35));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.55, 0.35, 0.6, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.6, 0.35, 0.6, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.65, 0.35, 0.5, 0.35));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.3, 0.4, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.35, 0.4, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, 0.4);
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.45, 0.4, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.5, 0.4, 0.65, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.55, 0.4, 0.6, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.6, 0.4, 0.6, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.65, 0.4, 0.65, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.3, 0.45, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.35, 0.45, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.4, 0.45, 0.4, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, 0.45);
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.5, 0.45, 0.65, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.55, 0.45, 0.6, 0.65));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.6, 0.45, 0.6, 0.65));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.65, 0.45, 0.65, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.3, 0.5, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.35, 0.5, 0.5, 0.35));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.4, 0.5, 0.65, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.45, 0.5, 0.65, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, 0.5);
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.55, 0.5, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.6, 0.5, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.65, 0.5, 0.5, 0.35));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.3, 0.55, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.35, 0.55, 0.6, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.4, 0.55, 0.6, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.45, 0.55, 0.6, 0.65));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.5, 0.55, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, 0.55);
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.6, 0.55, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.65, 0.55, 0.6, 0.65));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.3, 0.6, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.35, 0.6, 0.6, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.4, 0.6, 0.6, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.45, 0.6, 0.6, 0.65));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.5, 0.6, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.55, 0.6, 0.55, 0.6));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, 0.6);
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.65, 0.6, 0.6, 0.65));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.3, 0.65, 0.5, 0.35));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.35, 0.65, 0.5, 0.35));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.4, 0.65, 0.65, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.45, 0.65, 0.65, 0.45));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.5, 0.65, 0.5, 0.35));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.55, 0.65, 0.6, 0.65));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.6, 0.65, 0.6, 0.65));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, 0.65);
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.3, 0.7, 0.35, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.35, 0.7, 0.35, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.4, 0.7, 0.35, 0.4));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.45, 0.7, 0.5, 0.55));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.5, 0.7, 0.5, 0.55));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.55, 0.7, 0.5, 0.55));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.6, 0.7, 0.65, 0.015625));
	r0 = r0 + r1;
	r1 = tex2D(g_SamplerTexture, float4(0.65, 0.7, 0.65, 0.015625));
	r0 = r0 + r1;
	o = r0 * 0.015625;

	return o;
}
