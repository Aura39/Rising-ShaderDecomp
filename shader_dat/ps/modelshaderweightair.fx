float4 g_Ambient;
float4 g_Env;
float4 g_MatrialColor;
float4 g_Mie;
float4 g_Rayleigh;
sampler g_Sampler0;
float g_SetColor;
float g_SetNormal;
float g_SetTangent;
float4 g_Sun;
float4 g_Sun2Col;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	r0.w = -2;
	r0.x = i.texcoord1.x * r0.w + g_Mie.w;
	r0.y = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.x = r0.y * r0.x;
	r0.y = 1 + i.texcoord1.z;
	r0.yzw = r0.yyy * g_Rayleigh.xyz;
	r0.xyz = g_Mie.xyz * r0.xxx + r0.yzw;
	r1 = g_Ambient;
	r0.xyz = g_Sun.xyz * r0.xyz + r1.xyz;
	r0.w = g_Sun.w * i.texcoord1.y;
	r0.w = r0.w * r0.w + g_Env.w;
	r0.w = 1 / sqrt(r0.w);
	r0.w = 1 / r0.w;
	r0.w = g_Sun.w * -i.texcoord1.y + r0.w;
	r1 = r1.w + float4(-0.25, -0.5, -0.75, -1);
	r1 = abs(r1) * -4 + 1;
	r2 = max(r1, 0);
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1.x = dot(r1, r2);
	r1.y = i.texcoord2.w * i.texcoord2.w;
	r1.z = r1.y * r1.x;
	r1.x = r1.x * -r1.y + 1;
	r0.w = r1.z * 100000 + r0.w;
	r0.w = i.texcoord2.x * 200 + r0.w;
	r2.xyz = r0.www * -g_Env.xyz;
	r2.xyz = r2.xyz * 1.442695;
	r3.x = exp2(r2.x);
	r3.y = exp2(r2.y);
	r3.z = exp2(r2.z);
	r2.xyz = -r3.xyz + 1;
	r0.xyz = r0.xyz * r2.xyz;
	r0.xyz = r0.xyz * r1.xxx + r1.zzz;
	r0.w = 1 / i.texcoord4.w;
	r1.xy = r0.ww * i.texcoord4.xy;
	r0.w = 1 / i.texcoord3.w;
	r1.xy = i.texcoord3.xy * r0.ww + -r1.xy;
	r1.zw = r1.xx * 1.7777778;
	r0.w = dot(r1.w, r1.w) + 0;
	r0.w = 1 / sqrt(r0.w);
	r0.w = 1 / r0.w;
	r1.x = 0.15625;
	r1.x = r1.x * g_Rayleigh.w;
	r1.x = 1 / r1.x;
	r0.w = r0.w * -r1.x + 1;
	r1.x = max(r0.w, 0);
	r0.w = r1.x * r1.x;
	r1.x = r1.x * g_Sun2Col.w;
	r2 = r0.w * g_Sun2Col;
	r0.xyz = r0.xyz * g_MatrialColor.xyz + r2.xyz;
	r2.x = g_SetTangent.x;
	r1.y = r2.x + g_SetNormal.x;
	r1.y = r1.y + g_SetColor.x;
	r0.w = r1.y * 1E-21 + r1.x;
	o = r0 * 1E-15 + r2.w;

	return o;
}
