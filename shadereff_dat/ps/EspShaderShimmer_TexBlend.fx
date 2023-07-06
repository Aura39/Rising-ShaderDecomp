float4 g_BlendRate;
float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
sampler g_Sampler3;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = 1 / i.texcoord1.w;
	r0.xy = r0.xx * i.texcoord1.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r2 = tex2D(g_Sampler3, i.texcoord);
	r0.zw = lerp(r2.xy, r1.xy, g_BlendRate.xx);
	r0.zw = r0.zw + g_Rate.zw;
	r0.xy = r0.zw * g_Rate.xy + r0.xy;
	r0 = tex2D(g_Sampler1, r0);
	r1 = tex2D(g_Sampler2, i.texcoord);
	r0.w = lerp(r2.w, r1.w, g_BlendRate.x);
	o = r0 * g_MatrialColor;

	return o;
}
