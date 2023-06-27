float4 g_Color;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
float4 g_Weight;
float4 g_uvOffset;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.xy = g_uvOffset.xy + i.texcoord1.xy;
	r0 = tex2D(g_Sampler0, r0);
	r0 = r0.w + -0.5;
	clip(r0);
	r0.x = 1 / i.texcoord.w;
	r0.xy = r0.xx * i.texcoord.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + float2(0.000390625, 0.00069444446);
	r1 = tex2D(g_Sampler1, r0);
	r0.xy = r0.xy + g_Weight.zw;
	r2 = r1.w + -0.01;
	clip(r2);
	r0.zw = r0.xy + float2(-0.01, 0.00078125);
	r2 = tex2D(g_Sampler1, r0.zwzw);
	r0.z = r1.w + r2.w;
	r1.xy = r0.xy + float2(-0.00078125, -0.0013888889);
	r1 = tex2D(g_Sampler1, r1);
	r0.z = r0.z + r1.w;
	r1.xy = r0.xy + float2(-0.00078125, 0.0013888889);
	r1 = tex2D(g_Sampler1, r1);
	r0.z = r0.z + r1.w;
	r1.xy = r0.xy + float2(0.00078125, -0.0013888889);
	r0.xy = r0.xy + g_Weight.xy;
	r2 = tex2D(g_Sampler2, r0);
	r1 = tex2D(g_Sampler1, r1);
	r0.x = r0.z + r1.w;
	r0.x = r0.x * 0.2;
	r0 = r0.x * g_Color;
	o.xyz = r2.xxx * r0.xyz;
	o.w = r0.w;

	return o;
}
