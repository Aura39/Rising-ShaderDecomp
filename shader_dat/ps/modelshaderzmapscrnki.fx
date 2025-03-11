float4 g_CameraParam : register(c193);
float4x4 g_Proj : register(c4);
sampler g_Sampler0 : register(s0);
float4 g_preFogColor : register(c185);
float4 g_uvOffset : register(c184);

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
	r0.xy = g_uvOffset.xy + i.texcoord1.xy;
	r0 = tex2D(g_Sampler0, r0);
	r0.xy = float2(-0.81, -0.8);
	r0.yz = r0.ww * g_preFogColor.ww + r0.xy;
	r0.w = (-r0.y >= 0) ? 0 : 1;
	r0.y = (r0.y >= 0) ? -0 : -1;
	r1 = r0.y + r0.w;
	clip(r1);
	r0.y = 1 / i.texcoord.w;
	r0.y = r0.y * i.texcoord.z;
	r0.y = r0.y + transpose(g_Proj)[2].z;
	r0.y = 1 / r0.y;
	r0.w = transpose(g_Proj)[2].w;
	r0.y = r0.w * r0.y + -g_CameraParam.x;
	r0.w = 1 / g_CameraParam.y;
	r0.x = r0.w * r0.y;
	o = r0.xxxz;

	return o;
}
