float4 g_DirtColor;
float4 g_MatrialColor;
sampler g_Sampler0;
sampler g_Sampler1;

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
	r0.x = 1 / i.texcoord1.w;
	r0.xy = r0.xx * i.texcoord1.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0 = tex2D(g_Sampler1, r0);
	r0 = r0 * g_DirtColor;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1.x = r1.w * g_MatrialColor.w;
	o.w = r0.w * r1.x;
	o.xyz = r0.xyz;

	return o;
}
