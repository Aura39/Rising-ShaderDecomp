float4 g_MatrialColor : register(c184);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
float4 g_sp_color : register(c190);

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
	float2 r2;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1 = r0.w + -0.001;
	clip(r1);
	r1.x = -0.001;
	r1 = r0.w * g_MatrialColor.w + r1.x;
	clip(r1);
	r1.x = -0.5 + i.texcoord1.x;
	r1.x = r1.x * i.texcoord1.w;
	r1.x = r1.x * 0.00078125 + i.texcoord1.x;
	r1.y = r1.x + -0.5;
	r2.x = r0.x * i.texcoord1.z + r1.x;
	r1.x = r1.y * i.texcoord1.w;
	r1.x = r1.x * 0.0013888889 + i.texcoord1.y;
	r2.y = r0.y * i.texcoord1.z + r1.x;
	r1 = tex2D(g_Sampler1, r2);
	r0.xyz = g_sp_color.xyz * r0.www + r1.xyz;
	r0 = r0 * g_MatrialColor;
	o = r0;

	return o;
}
