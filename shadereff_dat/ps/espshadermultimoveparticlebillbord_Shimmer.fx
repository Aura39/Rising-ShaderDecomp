float4 g_MatrialColor;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0.w = g_MatrialColor.w;
	r0 = i.texcoord2.w * r0.w + -0.001;
	clip(r0);
	r0.x = 1 / i.texcoord.w;
	r0.xy = r0.xx * i.texcoord.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r1 = tex2D(g_Sampler0, i.texcoord1);
	r0.zw = r1.xy + g_Rate.zw;
	r0.xy = r0.zw * g_Rate.xy + r0.xy;
	r0 = tex2D(g_Sampler1, r0);
	r1 = tex2D(g_Sampler2, i.texcoord1);
	r0.w = r1.w;
	r1 = g_MatrialColor * i.texcoord2;
	o = r0 * r1;

	return o;
}
